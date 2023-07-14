Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 979B9C0015E
	for <linux-modules@archiver.kernel.org>; Fri, 14 Jul 2023 14:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236107AbjGNOmQ (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 14 Jul 2023 10:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbjGNOmP (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 14 Jul 2023 10:42:15 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1E63134;
        Fri, 14 Jul 2023 07:42:13 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 6A3E858B8DB3A; Fri, 14 Jul 2023 16:42:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 6779C6197F89B;
        Fri, 14 Jul 2023 16:42:12 +0200 (CEST)
Date:   Fri, 14 Jul 2023 16:42:12 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     Nicolas Schier <nicolas@fjasle.eu>, linux-modules@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] depmod: Handle installing modules under a prefix
In-Reply-To: <20230714143002.GL9196@kitsune.suse.cz>
Message-ID: <91qn266-1929-r36s-rrq-qs8n1qs044ps@vanv.qr>
References: <30d8c675-e769-e567-a81f-c1b59c66ad67@suse.com> <20230714122111.7528-1-msuchanek@suse.de> <ZLFWFoDHcvLGoUuv@fjasle.eu> <20230714143002.GL9196@kitsune.suse.cz>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Friday 2023-07-14 16:30, Michal Suchánek wrote:
>> >  
>> > -MODLIB	= $(INSTALL_MOD_PATH)/lib/modules/$(KERNELRELEASE)
>> > +export KERNEL_MODULE_PREFIX := $(shell kmod config &> /dev/null && kmod config | jq -r .module_prefix)
>> 
>> All other calls of `jq` that I could find are located at tools/; as this here
>> is evaluated on each invocation, this should probably be documented in
>> Documentation/process/changes.rst?
>> 
>> (Absence of `jq` will cause error messages, even with CONFIG_MODULES=n.)
>
>That's a good point.

Speaking of which, "&>" is a bashism and probably should be replaced.
