Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E5742C515;
	Fri, 31 Jul 2026 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785502982; cv=none; b=eY6QJAOV6O0cgHAe5wUplstcIK/eokC+VxyA1E7vTqtp2qInbYiYJ+YDAP24p4LTxwdn7gcw5JhnY3s7ocSX46YDErMLxxSatyigpWzHpLsBGsuKE+cTnZUS6JYFNQ0WTlzl17TkUnjMIXa26+SIkuT4uDYZ6Ko4rTgFmx1V7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785502982; c=relaxed/simple;
	bh=bLWCrFAN9m0vThC6I8y0IhbGnstlgg2nHWrMKYuN8LM=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=CKeeAhQ+GjL/70aX6mQOJnCYLtYB/3xNCN+0paSWoCxZJ19qECG9ITUrKvF5vLJzyqF5O1kvIM3iF7YFS/AdI/FEy2ySnbcZ+F9avzfciyWeR+QAeMgjBuiEDFoauqhH7wimSc+uiUfCz19NR1H8hjU0/vNvtmuWQLMQiYxhusI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZGJCtWF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZGJCtWF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3C901F00A3A;
	Fri, 31 Jul 2026 13:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785502980;
	bh=VDgNzLLzldqfhcRMHA2BBCtFqiecgmjA0e2OTYYxoy0=;
	h=From:Subject:Date:To:Cc;
	b=ZGJCtWF427tq8SDRAPngVDA2yEBzZaUpgbdf7kRKqqeey/Sl89N5MPqVNV2P2Vf/l
	 GSlQIPkYmLTcYmphtTAzJ3McSM/WcbfoOdqu8vqUndZ0RZ1g5CDx1t39Vh+dbQ6iXX
	 406kVdxaqR+jNajJXX3ABli0a/MPmCxEpvhxUMIY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v2 0/2] module: remove MODULE_VERSION() and srcversion
Date: Fri, 31 Jul 2026 15:02:22 +0200
Message-Id: <20260731-module_ver_remove-v2-0-c9163858f382@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMWwqDMBBG4a3IPDeQC7bQrUgRY37bKWrKRENB3
 HtjffweztkoQRiJ7tVGgsyJ41xgLxX1r25+QnEoJqvtVd+cUVMM64g2Q1rBFDPUEGpde2e9MYZ
 K9xEM/P0/m8fptPo3+uUY0b7/AMQ5Dil1AAAA
X-Change-ID: 20260731-module_ver_remove-fd505b32b111
To: Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, 
 Shyam Saini <shyamsaini@linux.microsoft.com>, Kees Cook <kees@kernel.org>, 
 Thorsten Blum <thorsten.blum@linux.dev>, 
 Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org, 
 linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Christoph Hellwig <hch@lst.de>
X-Mailer: b4 0.16-dev-401aa
X-Developer-Signature: v=1; a=openpgp-sha256; l=2003;
 i=gregkh@linuxfoundation.org; h=from:subject:message-id;
 bh=bLWCrFAN9m0vThC6I8y0IhbGnstlgg2nHWrMKYuN8LM=;
 b=owGbwMvMwCRo6H6F97bub03G02pJDFk5c75edT0ukeOXuc1j/eyL59/Uf9MSvvjLtH35pfOff
 fS6VojHdsSyMAgyMciKKbJ82cZzdH/FIUUvQ9vTMHNYmUCGMHBxCsBE3gQzzHdkv/C53k6HMynk
 YXX1yUzx/59kNBnmWWUU5zkvzfSw5MxULGI8+eNL+tvlAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp;
 fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29

Module "versions" do not make sense as the kernel is built all at once,
the "version" is the overall kernel version number, so modules can not
really be described as having a unique version given that they rely on
the infrastructure of the whole kernel.

So remove the version and the srcversion fields as there is no need for
them anymore.

Note, for now, MODULE_VERSION() is just an "empty" define, to keep
existing code building properly as the tree is slowly purged of the use
of this over time.  This macro will be removed entirely in the future
when there are no in-tree users.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
Changes in v2:
  - remove version from struct module and the sysfs file
  - amd driver THIS_MODULE->version logic removal as it's pointless.
  - add second patch in series to remove srcversion
  - Link to v1: https://lore.kernel.org/r/2026031341-evolve-repeater-987b@gregkh

---
Greg Kroah-Hartman (2):
      module: remove MODULE_VERSION()
      module: remove srcversion module attribute

 Documentation/ABI/stable/sysfs-module    | 12 -------
 arch/x86/tools/relocs.c                  |  1 -
 drivers/block/drbd/drbd_buildtag.c       |  7 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_virt.c |  7 +---
 include/asm-generic/vmlinux.lds.h        |  5 ---
 include/linux/module.h                   | 58 ++++++--------------------------
 kernel/module/Kconfig                    | 11 ------
 kernel/module/main.c                     | 32 ------------------
 kernel/params.c                          | 30 -----------------
 scripts/Makefile.modpost                 |  1 -
 scripts/mod/modpost.c                    | 24 -------------
 scripts/mod/modpost.h                    |  1 -
 12 files changed, 13 insertions(+), 176 deletions(-)
---
base-commit: 8ba098e6b6ff0db8edf28528d1552be261af30d4
change-id: 20260731-module_ver_remove-fd505b32b111

Best regards,
--  
Greg Kroah-Hartman <gregkh@linuxfoundation.org>

