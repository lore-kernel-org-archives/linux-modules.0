Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from e23smtp03.au.ibm.com ([202.81.31.145]:40341 "EHLO
	e23smtp03.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758970AbcAUMFv (ORCPT
	<rfc822;linux-modules@vger.kernel.org>);
	Thu, 21 Jan 2016 07:05:51 -0500
Received: from localhost
	by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-modules@vger.kernel.org> from <zohar@linux.vnet.ibm.com>;
	Thu, 21 Jan 2016 22:05:49 +1000
Message-ID: <1453377894.9549.83.camel@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v2 07/11] firmware: replace call to
 fw_read_file_contents() with kernel version
From: Mimi Zohar <zohar@linux.vnet.ibm.com>
To: Kees Cook <keescook@chromium.org>
Cc: linux-security-module <linux-security-module@vger.kernel.org>,
	"Luis R. Rodriguez" <mcgrof@suse.com>,
	Kexec Mailing List <kexec@lists.infradead.org>,
	linux-modules@vger.kernel.org,
	"linux-fsdevel@vger.kernel.org" <fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>
Date: Thu, 21 Jan 2016 07:04:54 -0500
In-Reply-To: <CAGXu5jLgkh5iNCW1nLR3o8omS4YH2o-SkL2AQK26W94hJ9UbHg@mail.gmail.com>
References: <1453129886-20192-1-git-send-email-zohar@linux.vnet.ibm.com>
	 <1453129886-20192-8-git-send-email-zohar@linux.vnet.ibm.com>
	 <CAGXu5jLgkh5iNCW1nLR3o8omS4YH2o-SkL2AQK26W94hJ9UbHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Tue, 2016-01-19 at 16:10 -0800, Kees Cook wrote:
> On Mon, Jan 18, 2016 at 7:11 AM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> > Replace fw_read_file_contents() for reading a file with the common VFS
> > kernel_read_file() function.  A benefit of calling kernel_read_file()
> > to read the firmware is the firmware is read only once, instead of once
> > for measuring/appraising the firmware and again for reading the file
> > contents into memory.
> >
> > This patch retains the kernel_fw_from_file() hook, which is called from
> > security_kernel_post_read_file(), but removes the
> > sercurity_kernel_fw_from_file() function.
> >
> > Changelog:
> > - reordered and squashed firmware patches
> > - fix MAX firmware size (Kees Cook)
> >
> > Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks!

Mimi

