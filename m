Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:51683 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760128AbcAUUi7 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 15:38:59 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Fri, 22 Jan 2016 06:38:57 +1000
Message-ID: <1453408672.9549.168.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 08/11] module: replace copy_module_from_fd with
 kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@suse.com>
Cc: Joey Lee <jlee@suse.com>, Gary Lin <GLin@suse.com>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Paul Moore <pmoore@redhat.com>,
	John Johansen <john.johansen@canonical.com>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	linux-security-module <linux-security-module@vger.kernel.org>,
	kexec@lists.infradead.org, linux-modules@vger.kernel.org,
	fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 21 Jan 2016 15:37:52 -0500
In-Reply-To: <CAB=NE6VS1xptdnmfPLC4fGmFwdBSjAHxcmK9ThLP4haHa_j6fA@mail.gmail.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1453129886-20192-9-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160121000300.GN11277@wotan.suse.de>
	 <1453381932.9549.131.camel@linux.vnet.ibm.com>
	 <CAB=NE6VS1xptdnmfPLC4fGmFwdBSjAHxcmK9ThLP4haHa_j6fA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, 2016-01-21 at 08:56 -0800, Luis R. Rodriguez wrote:
> On Thu, Jan 21, 2016 at 5:12 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > On Thu, 2016-01-21 at 01:03 +0100, Luis R. Rodriguez wrote:
> >> On Mon, Jan 18, 2016 at 10:11:23AM -0500, Mimi Zohar wrote:
> >> > This patch replaces the module copy_module_from_fd() call with the VFS
> >> > common kernel_read_file_from_fd() function.  Instead of reading the
> >> > kernel module twice, once for measuring/appraising and then loading
> >> > the kernel module, the file is read once.
> >> >
> >> > This patch defines a new security hook named security_kernel_read_file(),
> >> > which is called before reading the file.  For now, call the module
> >> > security hook from security_kernel_read_file until the LSMs have been
> >> > converted to use the kernel_read_file hook.
> >> >
> >> > This patch retains the kernel_module_from_file hook, but removes the
> >> > security_kernel_module_from_file() function.
> >>
> >> I think it would help if your cover letter and this patch described
> >> a bit that some LSMs either prefer to read / check / appraise files
> >> prior to loading and some other prefer to do that later. You could
> >> explain the LSM hook preferences and what they do. Then here you
> >> can explain how this one prefers a hook early, but acknowledge that
> >> the other one still exists.
> >
> > Before this patch set, IMA measured/appraised/audited a file before
> > allowing it to be accessed, causing the file in some cases to be read
> > twice.   This patch set changes that.  Files are read into memory and
> > then measured/appraised/audited.
> 
> Sounds like this could help also with performance, has any preliminary
> benchmarking been done to see the effect ?

In general, IMA's pre-reading a file has negligible performance impact,
if any.   Dmitry's LinuxCon 2013 Europe talk "Integrity Protection
Solutions in Linux" had some performance statistics.  I'm not sure this
change will have much of a performance impact.

> > By defining
> > the pre and post security hooks in this patch set, it permits each of
> > the LSMs to migrate to the new hooks independently of each other.   Lets
> > ask the LSM maintainers what they think.
> 
> I see -- yeah making this a 2 step thing makes sense, so long as the
> maintainers can later expect / understand what would be done in a
> second patch set. Breaking this down in two patch sets makes sense. 

I'll defer adding the pre and post security hooks to the subsequent
patch set.

Mimi

