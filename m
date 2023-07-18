Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F0BAEB64DD
	for <linux-modules@archiver.kernel.org>; Tue, 18 Jul 2023 12:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231628AbjGRMmq (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Tue, 18 Jul 2023 08:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjGRMmp (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Tue, 18 Jul 2023 08:42:45 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 157E5134;
        Tue, 18 Jul 2023 05:42:44 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id 87BA958718501; Tue, 18 Jul 2023 14:42:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id 85D2760E5C62B;
        Tue, 18 Jul 2023 14:42:42 +0200 (CEST)
Date:   Tue, 18 Jul 2023 14:42:42 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     =?UTF-8?Q?Michal_Such=C3=A1nek?= <msuchanek@suse.de>
cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v4 4/4] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
In-Reply-To: <20230718122731.GX9196@kitsune.suse.cz>
Message-ID: <7848n6p3-or5-38r3-rp14-3r5p24n43928@vanv.qr>
References: <20230711153126.28876-1-msuchanek@suse.de> <cover.1689589902.git.msuchanek@suse.de> <cc04472084dc016679598fcffafc788bbb6d9c0f.1689589902.git.msuchanek@suse.de> <76o21q7n-8qo8-37p6-oqno-q08nqpos471@vanv.qr> <20230718084300.GU9196@kitsune.suse.cz>
 <81n281ns-s8on-rsrn-pp61-q28pn42ns531@vanv.qr> <20230718102958.GW9196@kitsune.suse.cz> <pq42o77-73np-66r-rrn9-ns24o907n59@vanv.qr> <20230718122731.GX9196@kitsune.suse.cz>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Tuesday 2023-07-18 14:27, Michal Suchánek wrote:
>> >
>> >That breaks kmod for the usrmerged distributions, though.
>> 
>> Does it though?
>> The *distro* has /lib -> /usr/lib,
>> the *staging area* for installation does not.
>
>Yes, currently the fully installed distribution has the symlink, at
>least openSUSE does.
>
>However, there is a goal to remove it eventually, and even now it is not
>present at all times.

The ELF interpreter /lib/ld-linux.so.2 is hardcoded everywhere.

Making /lib a directory again and bindmounting/symlinking
all the ELF interpreters, that seems to entail a bit more work
than just leaving /lib as a symlink.
