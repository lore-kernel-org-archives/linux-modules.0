Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900C2C433F5
	for <linux-modules@archiver.kernel.org>; Tue, 11 Oct 2022 15:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231290AbiJKPxV (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 11 Oct 2022 11:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiJKPwy (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 11 Oct 2022 11:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B608C10052
        for <linux-modules@vger.kernel.org>; Tue, 11 Oct 2022 08:51:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665503494;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KeMqmm6RZi8nEiwf9Am5Lyu5xHfrJbfXudXrmpg8EVU=;
        b=aLZ5Mw5dCN7M5mHzO1Mn6O2MlpLR0y/1XDFvYPXc3uZ3pREt79ER1fr5LlIVaY5MvlB8ZD
        j879c3F2zME2NHiH6J82gBt81Oq2hyH0KD5gh2+IrhV90o8wktV3biNO+aDUynbbGjEHaD
        iCGuJUOcuFUaKAO9NOWd8VDYlk30wCo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-353-zo5anyIHPLuN4zQMVCLaxQ-1; Tue, 11 Oct 2022 11:51:33 -0400
X-MC-Unique: zo5anyIHPLuN4zQMVCLaxQ-1
Received: by mail-wr1-f72.google.com with SMTP id s4-20020adfbc04000000b0022e03fc10a9so4003285wrg.15
        for <linux-modules@vger.kernel.org>; Tue, 11 Oct 2022 08:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KeMqmm6RZi8nEiwf9Am5Lyu5xHfrJbfXudXrmpg8EVU=;
        b=xfkEJ6xlZ3tlRwPjWP4Fw8ke3i0rf1C6MaLxPxZOIN7ucjhoEdfGGTBL7KS+kFit6E
         zekzSPejZ1MVxzyeQrDXaGZfgdh+jzF+0QI3JLoKX0aWPjvGyZUqg5+XCpMWX7QssHNA
         3zurdH4NI8aPU02sMHjC6+BV82q6Osn35li6JkvIJh63Ef7nVm2XuUO6pmU6vI4QEOdw
         ylrAMKO4HZHzo5zua2nJDBHK3ccecC0kqAHI+w3b6ho2tHY4/eDzUJYUJLZ4p1gYRh7p
         lnY6eOFyPM4FkFemT/nA8CNTegs9ubaXQAiTz0VQEoLoMR+cM9Wrlxa/AVtToVLtL/KD
         qR2g==
X-Gm-Message-State: ACrzQf3GIZy3XPKv5mQvTq0L2nARSwGl9y3IS+Ewh+9dYUllzlyuj2Dm
        2lOx9G9ksXDQkdmQk8zZ4ftgaK9ZrBOlhMSGZH8yQ/3hZnGdygIOR4smVZZwDwGLYwezBuWo3Op
        007G/X2qyUdIOAYi0RQCWAEqj
X-Received: by 2002:adf:dec3:0:b0:22e:6efe:7861 with SMTP id i3-20020adfdec3000000b0022e6efe7861mr15840533wrn.454.1665503490701;
        Tue, 11 Oct 2022 08:51:30 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5sB9t5u06LkupTlbVy8ECDTcOLBS1O5d6P3Qmwe1/vtkKfuRgNig3wn4YTbJ9AGejvjbghHQ==
X-Received: by 2002:adf:dec3:0:b0:22e:6efe:7861 with SMTP id i3-20020adfdec3000000b0022e6efe7861mr15840520wrn.454.1665503490490;
        Tue, 11 Oct 2022 08:51:30 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id az29-20020a05600c601d00b003c6b70a4d69sm5485564wmb.42.2022.10.11.08.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 08:51:29 -0700 (PDT)
Date:   Tue, 11 Oct 2022 16:51:28 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     "Elliott, Robert (Servers)" <elliott@hpe.com>
Cc:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Unloaded tainted modules list with tcrypt
Message-ID: <20221011155128.k27rsgevfwyawvbh@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <MW5PR84MB1842AE1F86F2B66A5D57DAA5AB209@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
 <MW5PR84MB184240ECFBB251B8A9CC1B8EAB239@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <MW5PR84MB184240ECFBB251B8A9CC1B8EAB239@MW5PR84MB1842.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Tue 2022-10-11 00:09 +0000, Elliott, Robert (Servers) wrote:
> Changing to == seems to work well - that shows incremented counts
> rather than new entries:
> Unloaded tainted modules: tcrypt():40 padlock_aes():1 isst_if_mbox_msr():56 pcc_cpufreq():56 acpi_cpufreq():112

Hi Elliott,

Please note, any module that does not carry a taint should _not_
be on the aforementioned list. See the following which is already
in Linus' tree:

commit 47cc75aa92837a9d3f15157d6272ff285585d75d
Author: Aaron Tomlin <atomlin@redhat.com>
Date:   Fri Oct 7 14:38:12 2022 +0100

    module: tracking: Keep a record of tainted unloaded modules only
    
    This ensures that no module record/or entry is added to the
    unloaded_tainted_modules list if it does not carry a taint.
    
    Reported-by: Alexey Dobriyan <adobriyan@gmail.com>
    Fixes: 99bd9956551b ("module: Introduce module unload taint tracking")
    Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
    Acked-by: Luis Chamberlain <mcgrof@kernel.org>
    Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>

diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index a139e63b6f20..26d812e07615 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -22,6 +22,9 @@ int try_add_tainted_module(struct module *mod)
 
 	module_assert_mutex_or_preempt();
 
+	if (!mod->taints)
+		goto out;
+
 	list_for_each_entry_rcu(mod_taint, &unloaded_tainted_modules, list,
 				lockdep_is_held(&module_mutex)) {
 		if (!strcmp(mod_taint->name, mod->name) &&


-- 
Aaron Tomlin

