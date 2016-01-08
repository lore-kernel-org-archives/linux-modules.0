Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:48106 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754146AbcAHTdY (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Fri, 8 Jan 2016 14:33:24 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Sat, 9 Jan 2016 05:33:22 +1000
Message-ID: <1452281545.2651.14.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/5] vfs: support for a common kernel file loader
 (step 1)
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: linux-security-module@vger.kernel.org
Cc: "Luis R. Rodriguez" <mcgrof@suse.com>, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Date: Fri, 08 Jan 2016 14:32:25 -0500
In-Reply-To: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
References: <1452280924-28774-1-git-send-email-zohar@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Fri, 2016-01-08 at 14:21 -0500, Mimi Zohar wrote:
> For a while it was looked down upon to directly read files from Linux.
> These days there exists a few mechanisms in the kernel that do just this
> though to load a file into a local buffer. There are minor but important
> checks differences on each, we should take all the best practices from
> each of them, generalize them and make all places in the kernel that
> read a file use it.[1]
> 
> One difference is the method for opening the file.  In some cases we
> have a file, while in other cases we have a pathname or a file descriptor.
> 
> Another difference is the security hook calls, or lack of them.  In
> some versions there is a post file read hook, while in others there
> is a pre file read hook.
> 
> This patch set is the first attempt at resolving these differences.  It
> does not attempt to merge the different methods of opening a file, but
> defines a single common kernel file read function with two wrappers.
> Although this patch set defines two new security hooks for pre and post
> file read, it does not attempt to merge the existing security hooks.
> That is left as future work.
> 
> These patches are based on top of the "ima: measuring/appraising files
> read by the kernel".  The latest version of these patches can be found
> in the next-kernel-read branch of:
> git://git.kernel.org/pub/scm/linux/kernel/git/zohar/linux-integrity.git

[1] Taken from Luis Rodriguez's wiki -
http://kernelnewbies.org/KernelProjects/common-kernel-loader

Mimi

