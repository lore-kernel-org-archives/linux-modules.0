Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB382031E
	for <linux-modules@vger.kernel.org>; Thu,  9 Nov 2023 17:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RfNfR+9O";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="nr91UC3E"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50450269E;
	Thu,  9 Nov 2023 09:40:38 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id F3A3B1F8B0;
	Thu,  9 Nov 2023 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1699551637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y0b/o0koAsCuEuabXJXcxMBlyObTAOMF0FWY8H+D5Q=;
	b=RfNfR+9OVTB3kKJQtdF3Y6UQx9doyYYIsLl5C5IqTVaFnkH2Cxt9MVaWLxjmMzHNoJL4iS
	2UvLojQfKpka7lsG6uPNEPxcnBGVDy0nsEr4LopPSn9iKIeAOH2eTwSL1q9/NJSF2Oprju
	MxLUdEjg9suBgsTztIna8XwgsFEh7Rs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1699551637;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+Y0b/o0koAsCuEuabXJXcxMBlyObTAOMF0FWY8H+D5Q=;
	b=nr91UC3EffLvji6vGEqyz7ILJyCl/Vx5PeggZEJRk8l8qw+fZop3qQ/6wI21mw1XulC6NJ
	V/AdUgZ7juPC+uCQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by relay2.suse.de (Postfix) with ESMTPS id EF4622C145;
	Thu,  9 Nov 2023 17:40:35 +0000 (UTC)
Date: Thu, 9 Nov 2023 18:40:34 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Jan Engelhardt <jengelh@inai.de>
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
	Lucas De Marchi <lucas.de.marchi@gmail.com>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Jiri Slaby <jslaby@suse.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nicolas Schier <nicolas@fjasle.eu>, linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v5 5/5] libkmod, depmod, modprobe: Make directory
 for kernel modules configurable
Message-ID: <20231109174034.GW6241@kitsune.suse.cz>
References: <cover.1689589902.git.msuchanek@suse.de>
 <cover.1689681454.git.msuchanek@suse.de>
 <b878a01f09e250bb24dbaede71cc776217a8f862.1689681454.git.msuchanek@suse.de>
 <e3yow7ih6af2hxzkmjay2oan3jypmo4hda64vxvpfco66ajcew@i3zewn4nbklf>
 <o6n5s896-ppro-qs00-71q8-3s657s3190s9@vanv.qr>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <o6n5s896-ppro-qs00-71q8-3s657s3190s9@vanv.qr>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Oct 18, 2023 at 03:25:19AM +0200, Jan Engelhardt wrote:
> On Tuesday 2023-10-17 19:50, Lucas De Marchi wrote:
> >> +AC_ARG_WITH([module_directory],
> >> +        AS_HELP_STRING([--with-module-directory=DIR], [directory in which to
> >> look for kernel modules - typically '/lib/modules' or
> >> '${prefix}/lib/modules']),
> >> +        [], [with_module_directory=/lib/modules])
> >> +AC_SUBST([module_directory], [$with_module_directory])
> >
> > we will probably have "fun" results if we accept a relative path here.
> 
> $ ./configure --prefix=/usr --bindir=../bin
> configure: error: expected an absolute directory name for --bindir: ../bin
> 
> While such check does not exist for --with-module-directory, everyone
> has likely been well-trained not to use relative paths. Even if, say,
> cmake/meson *could* do it, it just would have never occurred to me to
> actually *utilize* it, because it is just too ambiguous and
> potentially dangerous.
> 
> Just think of all the fun you could have with LD_LIBRARY_PATH=".."

Is there an example of how this guarding against relative paths is done
in other options that accept directories?

There may be something for the built-in options but the existing custom
rootlibdir option does not seem to have anything either.

Thanks

Michal
