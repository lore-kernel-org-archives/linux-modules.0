Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44875 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932909AbcBDTzH (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 14:55:07 -0500
Date: Thu, 4 Feb 2016 20:55:05 +0100
From: "Luis R. Rodriguez" <mcgrof@kernel.org>
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: linux-security-module@vger.kernel.org, kexec@lists.infradead.org,
	linux-modules@vger.kernel.org, fsdevel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Kees Cook <keescook@chromium.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
	Eric Biederman <ebiederm@xmission.com>,
	Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v3 15/22] vfs: define kernel_copy_file_from_fd()
Message-ID: <20160204195505.GE12481@wotan.suse.de>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-16-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454526390-19792-16-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 03, 2016 at 02:06:23PM -0500, Mimi Zohar wrote:
> This patch defines kernel_read_file_from_fd(), a wrapper for the VFS
> common kernel_read_file().
> 
> Changelog:
> - Separated from the kernel modules patch
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

  Luis
