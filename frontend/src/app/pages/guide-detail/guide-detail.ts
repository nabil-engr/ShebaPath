import { Component, inject, OnInit, signal } from '@angular/core';
import { DatePipe, DOCUMENT } from '@angular/common';
import { ActivatedRoute, RouterLink } from '@angular/router';
import { switchMap } from 'rxjs';
import { HttpErrorResponse } from '@angular/common/http';
import { GuidesService } from '../../core/services/guides.service';
import { PdfExportService } from '../../core/services/pdf-export.service';
import { AuthService } from '../../core/services/auth.service';
import { BookmarkService } from '../../core/services/bookmark.service';
import { GuideDetail, GuideFaq } from '../../core/models/models';
import { ShareButtonComponent } from '../../Shared/share-button/share-button';
import { TagChipsComponent } from '../../Shared/tag-chips/tag-chips';
import { TranslateSyncService } from '../../core/services/translate-sync.service';
import { GuideSummary } from '../../core/models/models';
import { SeoService } from '../../core/services/seo.service';

const GUIDE_FAQS: Record<string, GuideFaq[]> = {
  'bangladesh-epassport-application-guide': [
    {
      question: 'কিভাবে ই-পাসপোর্ট আবেদন করব? (Kivabe passport korbo?)',
      answer: 'ই-পাসপোর্ট আবেদনের জন্য প্রথমে epassport.gov.bd পোর্টালে একটি অ্যাকাউন্ট খুলুন। এরপর সঠিক জাতীয় পরিচয়পত্র (NID) বা ১৭ ডিজিটের জন্ম নিবন্ধন অনুযায়ী অনলাইন ফর্মটি পূরণ করুন, পাসপোর্ট ফি পরিশোধ করুন এবং বায়োমেট্রিক ছবি ও ফিঙ্গারপ্রিন্ট দেওয়ার জন্য নির্দিষ্ট তারিখে আঞ্চলিক পাসপোর্ট অফিসে উপস্থিত হন।'
    },
    {
      question: 'পাসপোর্ট করতে কি কি কাগজপত্র লাগে? (Passport e apply er jonno ki ki lagbe?)',
      answer: 'প্রাপ্তবয়স্কদের (১৮+) ক্ষেত্রে মূল স্মার্ট কার্ড বা এনআইডি (NID) এবং আবেদন সারসংক্ষেপ (Application Summary) ও এ-চালান/ফি জমার রশিদ প্রয়োজন। ১৮ বছরের কম বয়সীদের ক্ষেত্রে অনলাইন ভেরিফাইড ১৭ ডিজিটের জন্ম নিবন্ধন সনদ এবং বাবা-মায়ের এনআইডি কপি লাগে। রিনিউ এর ক্ষেত্রে পুরাতন মূল পাসপোর্ট সাথে নিতে হবে।'
    },
    {
      question: 'ই-পাসপোর্টের সরকারি ফি কত টাকা? (E-passport fee koto?)',
      answer: '৪৮ পৃষ্ঠা ৫ বছর মেয়াদি পাসপোর্টের নিয়মিত ফি ৪,০২৫ টাকা এবং জরুরি ফি ৬,৩২৫ টাকা। ৪৮ পৃষ্ঠা ১০ বছর মেয়াদের জন্য নিয়মিত ৫,৭৫০ টাকা ও জরুরি ৮,০৫০ টাকা। ৬৪ পৃষ্ঠা ১০ বছর মেয়াদের জন্য নিয়মিত ৮,০৫০ টাকা ও জরুরি ১০,৩৫০ টাকা (১৫% ভ্যাট অন্তর্ভুক্ত)।'
    },
    {
      question: 'পাসপোর্টের জন্য পুলিশ ভেরিফিকেশন কি বাধ্যতামূলক? (Police verification process)',
      answer: 'প্রথমবার পাসপোর্ট আবেদনকারীদের ক্ষেত্রে স্থায়ী ও বর্তমান ঠিকানায় পুলিশ ভেরিফিকেশন আবশ্যক। তবে সাধারণ রি-ইস্যু বা রিনিউ এর ক্ষেত্রে যদি নাম, ঠিকানা বা তথ্যের কোন পরিবর্তন না থাকে, তবে সাধারণত পুলিশ ভেরিফিকেশনের প্রয়োজন হয় না।'
    },
    {
      question: 'জরুরি প্রয়োজনে কত দিনে পাসপোর্ট পাওয়া যায়? (Super express passport delivery)',
      answer: 'সুপার এক্সপ্রেস (Super Express) ডেলিভারিতে মাত্র ২ থেকে ৩ কর্মদিবসের মধ্যে এবং এক্সপ্রেস ডেলিভারিতে ৭ থেকে ১০ কর্মদিবসে পাসপোর্ট পাওয়া যায়। নিয়মিত (Regular) আবেদনে সময় লাগে ১৫ থেকে ২১ কর্মদিবস।'
    },
    {
      question: 'পাসপোর্ট ডেলিভারি স্ট্যাটাস চেক করবেন কিভাবে? (Passport tracking bd)',
      answer: 'epassport.gov.bd পোর্টালে Check Status অপশনে যান। আপনার Application ID বা অনলাইন রেজিস্ট্রেশন নম্বর এবং জন্মতারিখ ইনপুট করে সহজেই পাসপোর্টের সর্বশেষ অগ্রগতি ট্র্যাক করতে পারবেন।'
    }
  ],
  'passport': [
    {
      question: 'কিভাবে ই-পাসপোর্ট আবেদন করব? (Kivabe passport korbo?)',
      answer: 'ই-পাসপোর্ট আবেদনের জন্য প্রথমে epassport.gov.bd পোর্টালে একটি অ্যাকাউন্ট খুলুন। এরপর সঠিক জাতীয় পরিচয়পত্র (NID) বা ১৭ ডিজিটের জন্ম নিবন্ধন অনুযায়ী অনলাইন ফর্মটি পূরণ করুন, পাসপোর্ট ফি পরিশোধ করুন এবং বায়োমেট্রিক ছবি ও ফিঙ্গারপ্রিন্ট দেওয়ার জন্য নির্দিষ্ট তারিখে আঞ্চলিক পাসপোর্ট অফিসে উপস্থিত হন।'
    },
    {
      question: 'পাসপোর্ট করতে কি কি কাগজপত্র লাগে? (Passport e apply er jonno ki ki lagbe?)',
      answer: 'প্রাপ্তবয়স্কদের (১৮+) ক্ষেত্রে মূল স্মার্ট কার্ড বা এনআইডি (NID) এবং আবেদন সারসংক্ষেপ (Application Summary) ও এ-চালান/ফি জমার রশিদ প্রয়োজন। ১৮ বছরের কম বয়সীদের ক্ষেত্রে অনলাইন ভেরিফাইড ১৭ ডিজিটের জন্ম নিবন্ধন সনদ এবং বাবা-মায়ের এনআইডি কপি লাগে। রিনিউ এর ক্ষেত্রে পুরাতন মূল পাসপোর্ট সাথে নিতে হবে।'
    },
    {
      question: 'ই-পাসপোর্টের সরকারি ফি কত টাকা? (E-passport fee koto?)',
      answer: '৪৮ পৃষ্ঠা ৫ বছর মেয়াদি পাসপোর্টের নিয়মিত ফি ৪,০২৫ টাকা এবং জরুরি ফি ৬,৩২৫ টাকা। ৪৮ পৃষ্ঠা ১০ বছর মেয়াদের জন্য নিয়মিত ৫,৭৫০ টাকা ও জরুরি ৮,০৫০ টাকা। ৬৪ পৃষ্ঠা ১০ বছর মেয়াদের জন্য নিয়মিত ৮,০৫০ টাকা ও জরুরি ১০,৩৫০ টাকা (১৫% ভ্যাট অন্তর্ভুক্ত)।'
    },
    {
      question: 'পাসপোর্টের জন্য পুলিশ ভেরিফিকেশন কি বাধ্যতামূলক? (Police verification process)',
      answer: 'প্রথমবার পাসপোর্ট আবেদনকারীদের ক্ষেত্রে স্থায়ী ও বর্তমান ঠিকানায় পুলিশ ভেরিফিকেশন আবশ্যক। তবে সাধারণ রি-ইস্যু বা রিনিউ এর ক্ষেত্রে যদি নাম, ঠিকানা বা তথ্যের কোন পরিবর্তন না থাকে, তবে সাধারণত পুলিশ ভেরিফিকেশনের প্রয়োজন হয় না।'
    }
  ],
  'driving-licence-bangladesh-guide': [
    {
      question: 'কিভাবে বিআরটিএ ড্রাইভিং লাইসেন্স করব? (Kivabe driving licence korbo?)',
      answer: 'প্রথমে বিআরটিএ সেবা পোর্টাল (bsp.brta.gov.bd)-এ রেজিস্টার করুন। মেডিকেল সার্টিফিকেট আপলোড করে লার্নার ড্রাইভিং লাইসেন্স আবেদন ও ফি পেমেন্ট করুন। এরপর নির্ধারিত তারিখে লিখিত, মৌখিক ও প্র্যাকটিক্যাল পরীক্ষায় উত্তীর্ণ হয়ে বায়োমেট্রিক প্রদান করলেই স্মার্ট কার্ড লাইসেন্স পেয়ে যাবেন।'
    },
    {
      question: 'ড্রাইভিং লাইসেন্স করতে কি কি লাগে? (Driving licence requirements bd)',
      answer: 'ন্যূনতম অষ্টম শ্রেণি/জেএসসি পাসের সনদ, নিবন্ধিত ডাক্তারের স্বাক্ষরিত মেডিকেল সার্টিফিকেট (Medical-1 ফর্ম), মূল জাতীয় পরিচয়পত্র (NID), পাসপোর্ট সাইজ ছবি এবং পেশাদার লাইসেন্সের ক্ষেত্রে পুলিশ ক্লিয়ারেন্স সার্টিফিকেট প্রয়োজন।'
    },
    {
      question: 'বিআরটিএ ড্রাইভিং লাইসেন্সের সরকারি ফি কত? (BRTA driving licence fees)',
      answer: 'লার্নার ফি ৩৪৫ টাকা (একটি ক্যাটাগরি) বা ৫১৮ টাকা (মোটরসাইকেল + গাড়ি)। অপেশাদার স্মার্ট কার্ড লাইসেন্স (১০ বছর মেয়াদ) ৪,৫৫৭ টাকা এবং পেশাদার লাইসেন্স (৫ বছর মেয়াদ) ২,৮৩২ টাকা (ডাক মাশুল ও ১৫% ভ্যাটসহ)।'
    },
    {
      question: 'ড্রাইভিং টেস্ট ও ফিল্ড পরীক্ষা কিভাবে হয়? (Driving test rules bd)',
      answer: 'পরীক্ষার দিনে প্রথমে ট্রাফিক সাইন ও রোড নিয়মের ওপর লিখিত পরীক্ষা হয়, এরপর ইঞ্জিন মেকানিক্সের মৌখিক পরীক্ষা এবং শেষে মাঠের মধ্যে আঁকাবাঁকা জিকজ্যাক (Zigzag) ট্র্যাক, রিভার্স পার্কিং ও স্লোপ/র‍্যাম্প টেস্ট নেওয়া হয়।'
    }
  ],
  'driving-licence': [
    {
      question: 'কিভাবে বিআরটিএ ড্রাইভিং লাইসেন্স করব? (Kivabe driving licence korbo?)',
      answer: 'প্রথমে বিআরটিএ সেবা পোর্টাল (bsp.brta.gov.bd)-এ রেজিস্টার করুন। মেডিকেল সার্টিফিকেট আপলোড করে লার্নার ড্রাইভিং লাইসেন্স আবেদন ও ফি পেমেন্ট করুন। এরপর নির্ধারিত তারিখে লিখিত, মৌখিক ও প্র্যাকটিক্যাল পরীক্ষায় উত্তীর্ণ হয়ে বায়োমেট্রিক প্রদান করলেই স্মার্ট কার্ড লাইসেন্স পেয়ে যাবেন।'
    },
    {
      question: 'ড্রাইভিং লাইসেন্স করতে কি কি লাগে? (Driving licence requirements bd)',
      answer: 'ন্যূনতম অষ্টম শ্রেণি/জেএসসি পাসের সনদ, নিবন্ধিত ডাক্তারের স্বাক্ষরিত মেডিকেল সার্টিফিকেট (Medical-1 ফর্ম), মূল জাতীয় পরিচয়পত্র (NID), পাসপোর্ট সাইজ ছবি এবং পেশাদার লাইসেন্সের ক্ষেত্রে পুলিশ ক্লিয়ারেন্স সার্টিফিকেট প্রয়োজন।'
    },
    {
      question: 'বিআরটিএ ড্রাইভিং লাইসেন্সের সরকারি ফি কত? (BRTA driving licence fees)',
      answer: 'লার্নার ফি ৩৪৫ টাকা (একটি ক্যাটাগরি) বা ৫১৮ টাকা (মোটরসাইকেল + গাড়ি)। অপেশাদার স্মার্ট কার্ড লাইসেন্স (১০ বছর মেয়াদ) ৪,৫৫৭ টাকা এবং পেশাদার লাইসেন্স (৫ বছর মেয়াদ) ২,৮৩২ টাকা।'
    }
  ],
  'nid-correction-smart-card-reissue': [
    {
      question: 'অনলাইনে ভোটার আইডি বা এনআইডি সংশোধন কিভাবে করব? (Kivabe NID shongshodhon korbo?)',
      answer: 'নির্বাচন কমিশনের services.nidw.gov.bd ওয়েবসাইটে যান। এনআইডি নম্বর ও জন্মতারিখ দিয়ে একাউন্ট খুলে NID Wallet অ্যাপের মাধ্যমে ফেস ভেরিফিকেশন সম্পন্ন করুন। এরপর প্রোফাইল এডিটে গিয়ে প্রয়োজনীয় তথ্য সংশোধন, ফি প্রদান এবং প্রমাণস্বরূপ কাগজপত্র আপলোড করে সাবমিট করুন।'
    },
    {
      question: 'এনআইডি কার্ডে নাম ও জন্মতারিখ সংশোধনে কি কি প্রমাণপত্র লাগে? (NID correction documents)',
      answer: 'এসএসসি/সমমানের শিক্ষাগত সনদ, অনলাইন ডিজিটাল জন্ম নিবন্ধন সনদ, পাসপোর্ট বা ড্রাইভিং লাইসেন্স। পিতা-মাতার নাম সংশোধনের ক্ষেত্রে তাদের এনআইডি কপি অথবা ওয়ারিশান সনদ প্রয়োজন।'
    },
    {
      question: 'এনআইডি কার্ড সংশোধনের সরকারি ফি কত? (NID correction fees)',
      answer: 'প্রথমবার সংশোধনের জন্য ২৩০ টাকা (২০০ টাকা + ১৫% ভ্যাট), দ্বিতীয়বার ৩৪৫ টাকা এবং পরবর্তী প্রতিবার ৫৭৫ টাকা। হারিয়ে যাওয়া কার্ড উত্তোলনে নিয়মিত ২৩০ টাকা এবং জরুরি ৩৪৫ টাকা।'
    }
  ],
  'national-id': [
    {
      question: 'অনলাইনে ভোটার আইডি বা এনআইডি সংশোধন কিভাবে করব? (Kivabe NID shongshodhon korbo?)',
      answer: 'নির্বাচন কমিশনের services.nidw.gov.bd ওয়েবসাইটে যান। এনআইডি নম্বর ও জন্মতারিখ দিয়ে একাউন্ট খুলে NID Wallet অ্যাপের মাধ্যমে ফেস ভেরিফিকেশন সম্পন্ন করুন। এরপর প্রোফাইল এডিটে গিয়ে প্রয়োজনীয় তথ্য সংশোধন, ফি প্রদান এবং প্রমাণস্বরূপ কাগজপত্র আপলোড করে সাবমিট করুন।'
    },
    {
      question: 'এনআইডি কার্ডে নাম ও জন্মতারিখ সংশোধনে কি কি প্রমাণপত্র লাগে? (NID correction documents)',
      answer: 'এসএসসি/সমমানের শিক্ষাগত সনদ, অনলাইন ডিজিটাল জন্ম নিবন্ধন সনদ, পাসপোর্ট বা ড্রাইভিং লাইসেন্স।'
    },
    {
      question: 'এনআইডি কার্ড সংশোধনের সরকারি ফি কত? (NID correction fees)',
      answer: 'প্রথমবার সংশোধনের জন্য ২৩০ টাকা (২০০ টাকা + ১৫% ভ্যাট), দ্বিতীয়বার ৩৪৫ টাকা এবং পরবর্তী প্রতিবার ৫৭৫ টাকা।'
    }
  ],
  'online-birth-registration-bdris': [
    {
      question: 'অনলাইনে নতুন জন্ম নিবন্ধন কিভাবে করব? (Online birth registration application)',
      answer: 'bdris.gov.bd ওয়েবসাইটে গিয়ে নতুন জন্ম নিবন্ধনের জন্য আবেদন নির্বাচন করুন। ইউনিয়ন পরিষদ বা সিটি কর্পোরেশন জোন সিলেক্ট করে বাংলা ও ইংরেজিতে তথ্য পূরণ করুন, ইপিআই টিকা কার্ড বা হাসপাতালের ছাড়পত্র আপলোড করুন এবং প্রিন্ট কপি নিয়ে ১৫ দিনের মধ্যে স্থানীয় কার্যালয়ে জমা দিন।'
    },
    {
      question: 'জন্ম নিবন্ধনের সরকারি ফি কত টাকা? (Birth certificate registration fees)',
      answer: 'শিশুর জন্মের ৪৫ দিনের মধ্যে সম্পূর্ণ বিনামূল্যে। ৪৬ দিন থেকে ৫ বছর পর্যন্ত ২৫ টাকা। ৫ বছরের বেশি বয়সের ক্ষেত্রে ৫০ টাকা। ইংরেজি ভার্সন প্রতিলিপি ফি ৫০ টাকা এবং সংশোধন ফি ১০০ টাকা।'
    },
    {
      question: '১৭ ডিজিটের ডিজিটাল জন্ম নিবন্ধন সনদ কেন প্রয়োজন? (17 digit birth certificate)',
      answer: 'ই-পাসপোর্ট আবেদন, স্কুলে ভর্তি, এনআইডি তৈরি, বিবাহ নিবন্ধন এবং সরকারি যে কোনো সেবায় ১৭ ডিজিটের অনলাইন ডিজিটাল জন্ম নিবন্ধন সনদ বাধ্যতামূলক।'
    }
  ],
  'birth-certificate': [
    {
      question: 'অনলাইনে নতুন জন্ম নিবন্ধন কিভাবে করব? (Online birth registration application)',
      answer: 'bdris.gov.bd ওয়েবসাইটে গিয়ে নতুন জন্ম নিবন্ধনের জন্য আবেদন নির্বাচন করুন। ইউনিয়ন পরিষদ বা সিটি কর্পোরেশন জোন সিলেক্ট করে বাংলা ও ইংরেজিতে তথ্য পূরণ করুন, ইপিআই টিকা কার্ড বা হাসপাতালের ছাড়পত্র আপলোড করুন এবং প্রিন্ট কপি নিয়ে ১৫ দিনের মধ্যে স্থানীয় কার্যালয়ে জমা দিন।'
    },
    {
      question: 'জন্ম নিবন্ধনের সরকারি ফি কত টাকা? (Birth certificate registration fees)',
      answer: 'শিশুর জন্মের ৪৫ দিনের মধ্যে সম্পূর্ণ বিনামূল্যে। ৪৬ দিন থেকে ৫ বছর পর্যন্ত ২৫ টাকা। ৫ বছরের বেশি বয়সের ক্ষেত্রে ৫০ টাকা।'
    }
  ],
  'e-namjari-land-mutation-online': [
    {
      question: 'ই-নামজারি (মিউটেশন) আবেদন কিভাবে করবেন? (e-Namjari land mutation process)',
      answer: 'mutation.land.gov.bd পোর্টালে গিয়ে এনআইডি দিয়ে আবেদন করুন। জমির মৌজা, খতিয়ান ও দাগ নম্বর দিন, মূল দলিল, বায়া দলিল ও হালনাগাদ ভূমি উন্নয়ন কর (খাজনা) রশিদ আপলোড করুন। প্রারম্ভিক কোর্ট ফি ও নোটিশ ফি (৭০ টাকা) মোবাইল ব্যাংকিংয়ে পরিশোধ করুন।'
    },
    {
      question: 'নামজারি করতে সরকারি ফি মোট কত টাকা? (Namjari total government fee)',
      answer: 'সর্বমোট সরকারি ফি ১,১৭০ টাকা (কোর্ট ফি ২০ টাকা, নোটিশ জারি ফি ৫০ টাকা, রেকর্ড সংশোধন ফি ১,০০০ টাকা এবং খতিয়ান ফি ১০০ টাকা)। এটি সম্পূর্ণ অনলাইনে পরিশোধ করতে হয়, কোনো অতিরিক্ত ক্যাশ টাকা দেওয়ার নিয়ম নেই।'
    }
  ],
  'e-trade-license-bangladesh-online': [
    {
      question: 'অনলাইনে ই-ট্রেড লাইসেন্স কিভাবে পাব? (Online trade license apply process)',
      answer: 'সংশ্লিষ্ট সিটি কর্পোরেশন (যেমন etradelicense.dncc.gov.bd) বা পৌরসভা পোর্টালে লগইন করুন। ব্যবসার ধরন ও ঠিকানা নির্বাচন করুন, দোকান/অফিস ভাড়ার চুক্তিপত্র, টিন সার্টিফিকেট ও এনআইডি আপলোড করে ফি পরিশোধ করলেই কিউআর কোডযুক্ত ডিজিটাল ট্রেড লাইসেন্স ডাউনলোড করা যায়।'
    },
    {
      question: 'ট্রেড লাইসেন্স করতে কি কি লাগে? (Trade license required documents)',
      answer: 'উদ্যোক্তার জাতীয় পরিচয়পত্র (NID), পাসপোর্ট সাইজ ছবি, বাণিজ্যিক ভাড়ার চুক্তিপত্র বা জায়গার মালিকানার ট্যাক্স রশিদ, এবং ই-টিন (e-TIN) সার্টিফিকেট।'
    }
  ],
  'nbr-online-income-tax-return-filing': [
    {
      question: 'অনলাইনে ইনকাম ট্যাক্স রিটার্ন (e-Return) কিভাবে দাখিল করব? (Online tax return filing etaxnbr)',
      answer: 'etaxnbr.gov.bd পোর্টালে গিয়ে ১২ ডিজিটের ই-টিন (e-TIN) এবং বায়োমেট্রিক সিম দিয়ে সাইন-আপ করুন। আপনার বার্ষিক বেতন ও অন্যান্য আয়ের তথ্য এবং সম্পদ বিবরণী দিন। সিস্টেম স্বয়ংক্রিয়ভাবে কর হিসাব করবে; কর প্রযোজ্য হলে অনলাইনে পরিশোধ করে তাৎক্ষণিক প্রাপ্তিস্বীকার পত্র ও ট্যাক্স সার্টিফিকেট ডাউনলোড করুন।'
    },
    {
      question: 'শূন্য রিটার্ন (Zero Return) কি এবং কেন দাখিল করতে হয়? (Zero tax return bangladesh)',
      answer: 'করমুক্ত আয়ের সীমার (পুরুষ ৩.৫ লাখ, নারী ৪ লাখ) নিচে আয় থাকলে কোনো কর দিতে হয় না, তবে পিএসআর (PSR) সনদ পাওয়ার জন্য অনলাইনে রিটার্ন সাবমিট করতে হয়। এটিই শূন্য রিটার্ন এবং এটি তৈরি করতে মাত্র ৫–১০ মিনিট সময় লাগে।'
    }
  ]
};

@Component({
  selector: 'app-guide-detail',
  standalone: true,
  imports: [RouterLink, DatePipe, ShareButtonComponent, TagChipsComponent],
  templateUrl: './guide-detail.html',
  styleUrl: './guide-detail.scss',
})
export class GuideDetailPage implements OnInit {
  private readonly route = inject(ActivatedRoute);
  private readonly guidesService = inject(GuidesService);
  private readonly pdfExport = inject(PdfExportService);
  private readonly document = inject(DOCUMENT);
  protected readonly auth = inject(AuthService);
  protected readonly bookmarks = inject(BookmarkService);
  private readonly translateSync = inject(TranslateSyncService);
  private readonly seo = inject(SeoService);

  readonly guide = signal<GuideDetail | null>(null);
  readonly notFound = signal(false);
  readonly loadError = signal(false);
  readonly loading = signal(true);
  readonly savingBookmark = signal(false);
  readonly relatedGuides = signal<GuideSummary[]>([]);
  readonly faqs = signal<GuideFaq[]>([]);

  get pageUrl(): string {
    return this.document.location.href;
  }

  ngOnInit(): void {
    this.route.paramMap
      .pipe(switchMap((params) => this.guidesService.get(params.get('slug')!)))
      .subscribe({
        next: (guide) => {
          const guideFaqs = guide.faqs && guide.faqs.length > 0 ? guide.faqs : (GUIDE_FAQS[guide.slug] || []);
          this.faqs.set(guideFaqs);
          guide.faqs = guideFaqs;
          this.guide.set(guide);
          this.loading.set(false);
          this.seo.applyGuide(guide);
          this.translateSync.resync();
          this.guidesService.related(guide.slug).subscribe((g) => this.relatedGuides.set(g));
        },
        error: (error: HttpErrorResponse) => {
          const notFound = error.status === 404;
          this.notFound.set(notFound);
          this.loadError.set(!notFound);
          this.loading.set(false);
          this.seo.markUnavailable('Guide', notFound);
        },
      });

    if (this.auth.isAuthenticated() && !this.bookmarks.loaded()) {
      this.bookmarks.loadAll().subscribe();
    }
  }

  reload(): void {
    this.document.location.reload();
  }

  toggleBookmark(): void {
    const guide = this.guide();
    if (!guide || this.savingBookmark()) return;
    this.savingBookmark.set(true);
    this.bookmarks.toggle(guide.slug).subscribe({
      complete: () => this.savingBookmark.set(false),
      error: () => this.savingBookmark.set(false),
    });
  }

  downloadPdf(): void {
    if (typeof window !== 'undefined') {
      window.print();
    }
  }
}
