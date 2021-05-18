Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34AA0C433B4
	for <linux-modules@archiver.kernel.org>; Tue, 18 May 2021 15:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1924D6100C
	for <linux-modules@archiver.kernel.org>; Tue, 18 May 2021 15:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344083AbhERPFx (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 May 2021 11:05:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28794 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343903AbhERPFx (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 May 2021 11:05:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621350275;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VCjH/g9h4XFbuGATyoFy4uI7Xxpto4T6L4r3qd/p4/c=;
        b=fEuLG45Ldyg8lJcDcI/Pc9m6rSQs1JsC/dLNbEcBrY1FIrIrCsL5miiX2tbiuVp6cFJTmm
        1F5aq6dbnrzuB9PtxQan00kEv9Eayem95lDmCyQionZ1hKZwZV8+5t0HpmrpUSnSdWrH4E
        qCpHrx6p0OQMlqhMflsnGLqRndFaZh4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-568-K7a6znlfNzqioEwKfu4JSw-1; Tue, 18 May 2021 11:04:33 -0400
X-MC-Unique: K7a6znlfNzqioEwKfu4JSw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EED2A106BB2E;
        Tue, 18 May 2021 15:04:31 +0000 (UTC)
Received: from rvarghes.bos.com (ovpn-114-37.phx2.redhat.com [10.3.114.37])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3874710074E0;
        Tue, 18 May 2021 15:04:31 +0000 (UTC)
From:   Reuben Varghese <rvarghes@redhat.com>
To:     linux-modules@vger.kernel.org
Cc:     lucas.de.marchi@gmail.com, yauheni.kaliuta@redhat.com,
        reubenvarghese1 <rvarghes@redhat.com>
Subject: [PATCH v2 2/3] Update documentation reflecting change from blacklist to blocklist
Date:   Tue, 18 May 2021 08:03:18 -0700
Message-Id: <20210518150319.60941-3-rvarghes@redhat.com>
In-Reply-To: <20210518150319.60941-1-rvarghes@redhat.com>
References: <CAKi4VA+QqSkZMk+8=-9j7qH+_e7CRjW1mc+tVZ2V9Y+f=khe0w@mail.gmail.com>
 <20210518150319.60941-1-rvarghes@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

From: reubenvarghese1 <rvarghes@redhat.com>

With the introduction of inclusive language in the kmod module,
the documentation has been updated in this commit to reflect the
changes made.

Signed-off-by: Reuben Varghese <rvarghes@redhat.com>
---
 man/modprobe.d.xml | 8 ++++++--
 man/modprobe.xml   | 4 ++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/man/modprobe.d.xml b/man/modprobe.d.xml
index 0ab3e91..594a847 100644
--- a/man/modprobe.d.xml
+++ b/man/modprobe.d.xml
@@ -98,7 +98,7 @@
         </listitem>
       </varlistentry>
       <varlistentry>
-        <term>blacklist <replaceable>modulename</replaceable>
+        <term>blocklist <replaceable>modulename</replaceable>
         </term>
         <listitem>
           <para>
@@ -107,9 +107,13 @@
             "internal" aliases can be overridden by normal "alias" keywords,
             but there are cases where two or more modules both support the same
             devices, or a module invalidly claims to support a device that it
-            does not: the <command>blacklist</command> keyword indicates that
+            does not: the <command>blocklist</command> keyword indicates that
             all of that particular module's internal aliases are to be ignored.
           </para>
+          <para>
+            Note that the <command>blacklist</command> command is being
+            deprecated and has been refactored to <command>blocklist</command>.
+          </para>
         </listitem>
       </varlistentry>
       <varlistentry>
diff --git a/man/modprobe.xml b/man/modprobe.xml
index 0372b6b..9f4c78e 100644
--- a/man/modprobe.xml
+++ b/man/modprobe.xml
@@ -135,12 +135,12 @@
           <option>-b</option>
         </term>
         <term>
-          <option>--use-blacklist</option>
+          <option>--use-blocklist</option>
         </term>
         <listitem>
           <para>
             This option causes <command>modprobe</command> to apply the
-            <command>blacklist</command> commands in the configuration files
+            <command>blocklist</command> commands in the configuration files
             (if any) to module names as well.  It is usually used by
             <citerefentry>
               <refentrytitle>udev</refentrytitle><manvolnum>7</manvolnum>
-- 
2.27.0

