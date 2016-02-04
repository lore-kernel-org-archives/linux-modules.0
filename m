Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44497 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750936AbcBDTv0 (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 4 Feb 2016 14:51:26 -0500
Date: Thu, 4 Feb 2016 20:51:24 +0100
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
Subject: Re: [PATCH v3 13/22] firmware: replace call to
 fw_read_file_contents() with kernel version
Message-ID: <20160204195124.GC12481@wotan.suse.de>
References: <1454526390-19792-1-git-send-email-zohar@linux.vnet.ibm.com>
 <1454526390-19792-14-git-send-email-zohar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1454526390-19792-14-git-send-email-zohar@linux.vnet.ibm.com>
Sender: owner-linux-modules@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On Wed, Feb 03, 2016 at 02:06:21PM -0500, Mimi Zohar wrote:
> Replace the fw_read_file_contents with kernel_file_read_from_path().
> 
> Although none of the upstreamed LSMs define a kernel_fw_from_file hook,
> IMA is called by the security function to prevent unsigned firmware from
> being loaded and to measure/appraise signed firmware, based on policy.
> 
> Instead of reading the firmware twice, once for measuring/appraising the
> firmware and again for reading the firmware contents into memory, the
> kernel_post_read_file() security hook calculates the file hash based on
> the in memory file buffer.  The firmware is read once.
> 
> This patch removes the LSM kernel_fw_from_file() hook and security call.
> 
> Changelog v3:
> - remove kernel_fw_from_file hook
> - use kernel_file_read_from_path() - requested by Luis
> v2:
> - reordered and squashed firmware patches
> - fix MAX firmware size (Kees Cook)
> 
> Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>

Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>

 Luis
