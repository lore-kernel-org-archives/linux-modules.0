Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from smtpo51.poczta.onet.pl ([213.180.142.182]:42626 "EHLO
        smtpo51.poczta.onet.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdDNMtd (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 14 Apr 2017 08:49:33 -0400
Received: from pmq1v.m5r2.onet (pmq1v.m5r2.onet [10.174.32.67])
        by smtp.poczta.onet.pl (Onet) with ESMTP id 3w4HMJ0hVczpJWJ2
        for <linux-modules@vger.kernel.org>; Fri, 14 Apr 2017 14:41:00 +0200 (CEST)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
From: "wiktoria.lewicka" <wiktoria.lewicka@vp.pl>
To: "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>
Date: Fri, 14 Apr 2017 14:40:57 +0200
Message-Id: <31409372-d49fd76ae2d3ad793928c24c2388160b@pmq1v.m5r2.onet>
Subject: Why these functions are empty?
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

Hello!
I looked at code in include/linux/module.h and I found empty functions:

static inline void print_modules(void)
{
}

static inline unsigned long module_kallsyms_lookup_name(const char *name)
{
	return 0;
}

static inline int lookup_module_symbol_name(unsigned long addr, char *symna=
me)
{
	return -ERANGE;
}

And why these function haven`t implementation:
static inline int register_module_notifier(struct notifier_block *nb)
{
	/* no events will happen anyway, so this can always succeed */
	return 0;
}

static inline int unregister_module_notifier(struct notifier_block *nb)
{
	return 0;
}

Is module notifier doesn`t exists?
