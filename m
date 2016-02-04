Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp06.au.ibm.com ([202.81.31.148]:34901 "EHLO
	e23smtp06.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758223AbcBDXz4 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 18:55:56 -0500
Received: from localhost
	by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Fri, 5 Feb 2016 09:55:54 +1000
Message-ID: <1454630096.2648.14.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 00/22] vfs: support for a common kernel file loader
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Kexec Mailing List <kexec@lists.infradead.org>,
	linux-modules@vger.kernel.org, David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 04 Feb 2016 18:54:56 -0500
In-Reply-To: <CAGXu5jKve+Lcm+m69L_hGDWtL67H8ndJLq+MpRNVsF9N0-buAw@mail.gmail.com>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <CAGXu5jKve+Lcm+m69L_hGDWtL67H8ndJLq+MpRNVsF9N0-buAw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, 2016-02-04 at 10:15 -0800, Kees Cook wrote:
> On Wed, Feb 3, 2016 at 11:06 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > For a while it was looked down upon to directly read files from Linux.
> > These days there exists a few mechanisms in the kernel that do just this
> > though to load a file into a local buffer. There are minor but important
> > checks differences on each, we should take all the best practices from
> > each of them, generalize them and make all places in the kernel that
> > read a file use it.[1]
> >
> > One difference is the method for opening the file.  In some cases we
> > have a file, while in other cases we have a pathname or a file descriptor.
> >
> > Another difference is the security hook calls, or lack of them.  In
> > some versions there is a post file read hook, while in others there
> > is a pre file read hook.
> >
> > This patch set attempts to resolve these differences.  It does not attempt
> > to merge the different methods of opening a file, but defines a single
> > common kernel file read function with two wrappers. In addition, as none
> > of the upstreamed LSMs define either a kernel_module_from_file or a
> > kernel_fw_from_file hook, this patch set removes these hooks and the
> > associated functions.  The ima_module_check() and ima_fw_from_file()
> > functions are renamed and called from the pre and post kernel_read_file
> > security functions respectively.
> 
> I'm very happy about the pre and post hooks; this solves the primary
> problem I'd had when comparing the firmware and module hooks. Thanks!

Thank you for reviewing the patches!  

> Once this series is in -next, I'll resend my rebased "loadpin" LSM.

I was looking for this reference, when writing the patch description for
modules, but couldn't remember it.  Commit 2e72d51 "security: introduce
kernel_module_from_file hook" patch description references Chrome OS. 

Thanks!

Mimi

