Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D371E489;
	Sun,  3 Aug 2025 13:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754227105; cv=none; b=eQTAwypnTfZSeMeyOHUvG7GjYJZoL/d/o1gX9snZcIoEVdD/ZWwDYjw9nxBYnJQ3fObc6rCsCgqCiAL3uMKh+uc5AQYb5D9r0G7JQpb+57AKYr00wGdfhB2GPf22M2WzLAw84DTg/BeIefcEeXjKDU5mmyhThq2giJZeatQXxT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754227105; c=relaxed/simple;
	bh=3x04urBqGU+bb+qudggtjaqvo5T1JR32WxVhv/ZRVpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tLq6S15WVlDwg4VzzQieFthRAGaRE9bJHiqbKWLRWPIyhkkj7zuWpd17GVeluZukL0M7XFCSERtSnehQlaKf6l6JNZFqcIEpRyWuavltAB5QvZlgdHXRoiRqmBZ5Gde9w1eh56kMuZD9hDgDBaHuCLPOsGhfPs+m2890jk0TeT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1WxsETv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1WxsETv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E658C4CEEB;
	Sun,  3 Aug 2025 13:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754227105;
	bh=3x04urBqGU+bb+qudggtjaqvo5T1JR32WxVhv/ZRVpg=;
	h=From:To:Cc:Subject:Date:From;
	b=D1WxsETvlMOcGJF/wrp9Voml6rU1FTnPMogn/n8kMPgBWz61mg1Py0z2DddHfNLsI
	 w4+S1DF3T+nTzQevtuCCL/K71i6yQ8vzCyja3MwV+rW6NRCp9N0crHxOz/DovKgeNS
	 QNzIr82LLdB1GJiWyd80uT0Bbs6tq5wYyDQbUf6r3vNXIF10xBrmVoNHFEobM3iXRU
	 xxzpt94JWiKF9EZ9S3f//DZKZ/iOW6zeMJwakgGyjlU9c2Zt3+C4MYUvLhngPO1dxC
	 DJ8SItP6GD+6NwmFkLbODl1DjXRIPrpftXu7csWUrlIFIxy2AMEfw7SRH13vBvq5fv
	 YiKKmMgUDJzog==
From: Daniel Gomez <da.gomez@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	David Gow <davidgow@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] Modules changes for v6.17-rc1
Date: Sun,  3 Aug 2025 15:18:07 +0200
Message-ID: <20250803131809.4890-1-da.gomez@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 260f6f4fda93c8485c8037865c941b42b9cba5d2:

  Merge tag 'drm-next-2025-07-30' of https://gitlab.freedesktop.org/drm/kernel (2025-07-30 19:26:49 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.17-rc1

for you to fetch changes up to 40a826bd6c82ae45cfd3a19cd2a60a10f56b74c0:

  module: Rename MAX_PARAM_PREFIX_LEN to __MODULE_NAME_LEN (2025-07-31 13:57:47 +0200)

----------------------------------------------------------------
This is a small set of changes for modules, primarily to extend module users
to use the module data structures in combination with the already no-op stub
module functions, even when support for modules is disabled in the kernel
configuration. This change follows the kernel's coding style for conditional
compilation and allows kunit code to drop all CONFIG_MODULES ifdefs, which is
also part of the changes. This should allow others part of the kernel to do the
same cleanup.

Note that this had a conflict with sysctl changes [1] but should be fixed now as I
rebased on top.

The remaining changes include a fix for module name length handling which could
potentially lead to the removal of an incorrect module, and various cleanups.

The module name fix and related cleanup has been in linux-next since Thursday
(July 31) while the rest of the changes for a bit more than 3 weeks.

Note that this currently has conflicts in next with kbuild's tree [2].

Link: https://lore.kernel.org/all/20250714175916.774e6d79@canb.auug.org.au/ [1]
Link: https://lore.kernel.org/all/20250801132941.6815d93d@canb.auug.org.au/ [2]

----------------------------------------------------------------
Petr Pavlu (5):
      module: Prevent silent truncation of module name in delete_module(2)
      module: Remove unnecessary +1 from last_unloaded_module::name size
      module: Restore the moduleparam prefix length check
      tracing: Replace MAX_PARAM_PREFIX_LEN with MODULE_NAME_LEN
      module: Rename MAX_PARAM_PREFIX_LEN to __MODULE_NAME_LEN

Thomas Weißschuh (3):
      module: move 'struct module_use' to internal.h
      module: make structure definitions always visible
      kunit: test: Drop CONFIG_MODULE ifdeffery

 include/linux/module.h      | 29 +++++++++++------------------
 include/linux/moduleparam.h | 15 +++++++++------
 kernel/module/internal.h    |  7 +++++++
 kernel/module/main.c        | 12 +++++++-----
 kernel/trace/trace.c        |  2 +-
 lib/kunit/test.c            |  8 --------
 6 files changed, 35 insertions(+), 38 deletions(-)
