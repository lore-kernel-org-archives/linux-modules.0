Return-Path: <linux-modules-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659EFC43334
	for <linux-modules@archiver.kernel.org>; Sat, 11 Jun 2022 01:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350738AbiFKBn3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-modules@archiver.kernel.org>);
        Fri, 10 Jun 2022 21:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244611AbiFKBnR (ORCPT
        <rfc822;linux-modules@vger.kernel.org>);
        Fri, 10 Jun 2022 21:43:17 -0400
X-Greylist: delayed 605 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 10 Jun 2022 18:43:16 PDT
Received: from relay5.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F8C443E0E
        for <linux-modules@vger.kernel.org>; Fri, 10 Jun 2022 18:43:16 -0700 (PDT)
Received: from omf03.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay07.hostedemail.com (Postfix) with ESMTP id A5CAC21849;
        Sat, 11 Jun 2022 01:33:09 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf03.hostedemail.com (Postfix) with ESMTPA id C68C36000F;
        Sat, 11 Jun 2022 01:33:07 +0000 (UTC)
Message-ID: <c86b53f8d8c60a16a4cb3b34ac9ab2ab8b992595.camel@perches.com>
Subject: Re: [PATCH 5/7] checkpatch: warn if <asm/export.h> is included
From:   Joe Perches <joe@perches.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-kbuild@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Fri, 10 Jun 2022 18:33:06 -0700
In-Reply-To: <20220610183236.1272216-6-masahiroy@kernel.org>
References: <20220610183236.1272216-1-masahiroy@kernel.org>
         <20220610183236.1272216-6-masahiroy@kernel.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Rspamd-Queue-Id: C68C36000F
X-Stat-Signature: de5mfnp8ux5zw686hw4ahh34rdrwa9om
X-Rspamd-Server: rspamout02
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+Z+c4AphhDFTvORlz0qKlomJRpQrbLtJA=
X-HE-Tag: 1654911187-1721
Precedence: bulk
List-ID: <linux-modules.vger.kernel.org>

On Sat, 2022-06-11 at 03:32 +0900, Masahiro Yamada wrote:
> With the previous refactoring,
> 
>  - <asm/export.h> is a wrapper of <asm-generic/export.h>
>  - <asm-generic/export.h> is a wrapper of <linux/export.h>
> 
> My hope is to replace
> 
>    #include <asm/export.h>  -->  #include <linux/export.h>
> 
> for all *.S files.
> 
> For now, adding a warning in the checkpatch.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>  scripts/checkpatch.pl | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3753,6 +3753,13 @@ sub process {
>  			     "Avoid using '.L' prefixed local symbol names for denoting a range of code via 'SYM_*_START/END' annotations; see Documentation/asm-annotations.rst\n" . $herecurr);
>  		}
>  
> +# warn if <asm/export.h> is included.
> +# <asm/export.h> is a wrapper of <linux/export.h>. Please include <linux/export.h> directly.
> +		if ($tree && $rawline =~ m{^.\s*\#\s*include\s*\<asm\/export\.h\>}) {
> +			WARN("INCLUDE_LINUX_EXPORT",
> +			    "Please include <linux/export.h> instead of <asm/export.h>\n" . $herecurr);
> +		}

This warns on patch context lines.
That's not something checkpatch generally does.

Likely this should use /^\+ rather than /^.

And it's nice to have --fix capability

			if (WARN("etc...") &&
			    $fix) {
				$fixed[$fixlinenr] =~ s/\s*#\s*include\s*\<asm\/export\.h\>/#include <linux/export.h>/;
			}

cheers, Joe
