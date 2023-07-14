Return-Path: <linux-modules-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD1DEB64DA
	for <linux-modules@archiver.kernel.org>; Fri, 14 Jul 2023 13:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235922AbjGNNwi (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 14 Jul 2023 09:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235918AbjGNNwW (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 14 Jul 2023 09:52:22 -0400
Received: from a3.inai.de (a3.inai.de [IPv6:2a01:4f8:10b:45d8::f5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 563C53C32;
        Fri, 14 Jul 2023 06:52:07 -0700 (PDT)
Received: by a3.inai.de (Postfix, from userid 25121)
        id CE86B58750830; Fri, 14 Jul 2023 15:52:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by a3.inai.de (Postfix) with ESMTP id CC4E960C22668;
        Fri, 14 Jul 2023 15:52:05 +0200 (CEST)
Date:   Fri, 14 Jul 2023 15:52:05 +0200 (CEST)
From:   Jan Engelhardt <jengelh@inai.de>
To:     Michal Suchanek <msuchanek@suse.de>
cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v2 3/4] kmod: Add config command to show compile
 time configuration as JSON
In-Reply-To: <20230712140103.5468-3-msuchanek@suse.de>
Message-ID: <429o975-ro63-o94r-qs96-76ro6o28on5@vanv.qr>
References: <20230711153126.28876-1-msuchanek@suse.de> <20230712140103.5468-3-msuchanek@suse.de>
User-Agent: Alpine 2.25 (LSU 592 2021-09-18)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>


On Wednesday 2023-07-12 16:00, Michal Suchanek wrote:

>Show prefix (where configuration files are searched/to be installed),
>module compressions, and module signatures supported.

What about doing it like systemd and generate a .pc file instead 
that can then be queried like so, e.g.:

$ pkg-config kmod --variable=modulesdir
/usr/lib/modules
