Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp07.au.ibm.com ([202.81.31.140]:58644 "EHLO
	e23smtp07.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756896AbcBEAU1 (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 19:20:27 -0500
Received: from localhost
	by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Fri, 5 Feb 2016 10:20:24 +1000
Message-ID: <1454631566.2648.23.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 16/22] module: replace copy_module_from_fd with
 kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Date: Thu, 04 Feb 2016 19:19:26 -0500
In-Reply-To: <20160204195601.GF12481@wotan.suse.de>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1454526390-19792-17-git-send-email-zohar@linux.vnet.ibm.com>
	 <20160204195601.GF12481@wotan.suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Thu, 2016-02-04 at 20:56 +0100, Luis R. Rodriguez wrote:
> On Wed, Feb 03, 2016 at 02:06:24PM -0500, Mimi Zohar wrote:
> > Replace copy_module_from_fd() with kernel_read_file_from_fd().
> > 
> > Although none of the upstreamed LSMs define a kernel_module_from_file
> > hook, IMA is called, based on policy, to prevent unsigned kernel modules
> > from being loaded by the original kernel module syscall and to
> > measure/appraise signed kernel modules.
> > 
> > The security function security_kernel_module_from_file() was called prior
> > to reading a kernel module.  Preventing unsigned kernel modules from being
> > loaded by the original kernel module syscall remains on the pre-read
> > kernel_read_file() security hook.  Instead of reading the kernel module
> > twice, once for measuring/appraising and again for loading the kernel
> > module, the signature validation is moved to the kernel_post_read_file()
> > security hook.
> > 
> > This patch removes the security_kernel_module_from_file() hook and security
> > call.
> > 
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

Thank you for reviewing the patches!

Mimi

