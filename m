Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59772 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751084AbdDQO3W (ORCPT <rfc822;linux-modules@vger.kernel.org>);
        Mon, 17 Apr 2017 10:29:22 -0400
From: Yauheni Kaliuta <yauheni.kaliuta@redhat.com>
To: "wiktoria.lewicka" <wiktoria.lewicka@vp.pl>
Cc: "linux-modules\@vger.kernel.org" <linux-modules@vger.kernel.org>
Subject: Re: Why these functions are empty?
References: <31409372-d49fd76ae2d3ad793928c24c2388160b@pmq1v.m5r2.onet>
Date: Mon, 17 Apr 2017 17:29:18 +0300
In-Reply-To: <31409372-d49fd76ae2d3ad793928c24c2388160b@pmq1v.m5r2.onet>
        (wiktoria lewicka's message of "Fri, 14 Apr 2017 14:40:57 +0200")
Message-ID: <xunylgqzrttt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hi, wiktoria!

>>>>> On Fri, 14 Apr 2017 14:40:57 +0200, wiktoria lewicka  wrote:

 > Hello!
 > I looked at code in include/linux/module.h and I found empty functions:

 > static inline void print_modules(void)
 > {
 > }

 > static inline unsigned long module_kallsyms_lookup_name(const char *name)
 > {
 > 	return 0;
 > }

 > static inline int lookup_module_symbol_name(unsigned long addr, char *symname)
 > {
 > 	return -ERANGE;
 > }

 > And why these function haven`t implementation:
 > static inline int register_module_notifier(struct notifier_block *nb)
 > {
 > 	/* no events will happen anyway, so this can always succeed */
 > 	return 0;
 > }

 > static inline int unregister_module_notifier(struct notifier_block *nb)
 > {
 > 	return 0;
 > }

 > Is module notifier doesn`t exists?

This is "#else" branch of "#ifdef CONFIG_MODULES".

-- 
WBR,
Yauheni Kaliuta
