Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACFD25CC42;
	Wed, 15 Oct 2025 22:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760566440; cv=none; b=js0pHq87t7piutXZZHZql2Xv++91TKuZyZ0zCVCVgqPQkY9mJnpJ0yWiKWxQKbL4xIOEBP8f6QzVCyCNj/ontK3W+P8vwOFyd+4f83ZDm+plN9QKGxy1Eivjuz78DwTAz+qj7z7BYZB8xw0YiPm/jf59gnmfUuBGJ0UjxJ9g9Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760566440; c=relaxed/simple;
	bh=lflK08J16cTMx4WuLjNOgxxlgtAVe2/52J7emRhxryE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z4edh5eKyQR6VNWPnIW8a/xWAKNzcAaAO+T2hi34P60IYzpI6UkakW5N1TPwfKVBx+k/8GDHhXB7neYluWTQFnnWEwYldxxMvTBVsQNNfdmZUSmp71NR+iG+YhMLe1Ef5DmKMBnBKfKCSxdIylkAjc+VEQbdxiYeBFHsPbb4OVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=rDd+XhSi; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="rDd+XhSi"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=T8wLHD0m/27poTYVGSwQZlCS60yfCex8z0qJJuClWLI=; b=rDd+XhSiO7jBwlbvDV5uJFG3Yz
	zgmEB2Fiut4Pl7fidXeA6sEMGEQII+L4tINqAfLECoIvMCcJ3TJlY1y2XNnS9aqTyt7lAPGUzOO00
	moknivRgu282visnbV3+i/nlJzAjB1PF6UiHpyVauAKTr5FEOk6xiDp+qTm3uk3JKiKy2sq7DS4kv
	EpGS03JrlzWXXDkXar+2JLmAoWgjZ0N0E0l52RMs5o41JfE1kFaFYym4F18Tyr1g0c5BIQhMsqBOQ
	C5Nfx+BxkQ3XiPVPo9MbUUXBFQPZ5MXyPz1IqTcRvxzhKoIU+JQw7ZxHDzdzSNQ6Bjsq09r7n0wB2
	mSfqMYDw==;
Received: from [50.53.43.113] (helo=smtpauth.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v99ko-00000007jYy-4BU7;
	Wed, 15 Oct 2025 22:13:56 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org
Subject: [PATCH] docs: ABI: sysfs-module: list all taint flags
Date: Wed, 15 Oct 2025 15:13:48 -0700
Message-ID: <20251015221348.1125295-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The list of module taint flags has not been updated lately as the
taint flags list grows. Instead of trying to keep multiple lists
updated, just refer to the list of kernel taint flags since they are
the same.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org
---
 Documentation/ABI/testing/sysfs-module        |   10 ++--------
 Documentation/admin-guide/tainted-kernels.rst |    2 ++
 2 files changed, 4 insertions(+), 8 deletions(-)

--- linux-next-20251014.orig/Documentation/ABI/testing/sysfs-module
+++ linux-next-20251014/Documentation/ABI/testing/sysfs-module
@@ -52,14 +52,8 @@ What:		/sys/module/*/taint
 Date:		Jan 2012
 KernelVersion:	3.3
 Contact:	Kay Sievers <kay.sievers@vrfy.org>
-Description:	Module taint flags:
-			==  =====================
-			P   proprietary module
-			O   out-of-tree module
-			F   force-loaded module
-			C   staging driver module
-			E   unsigned module
-			==  =====================
+Description:	Module taint flags: same as the kernel taint flags.
+		See: :ref:`taint_flags` in Documentation/admin-guide/tainted-kernels.rst
 
 What:		/sys/module/grant_table/parameters/free_per_iteration
 Date:		July 2023
--- linux-next-20251014.orig/Documentation/admin-guide/tainted-kernels.rst
+++ linux-next-20251014/Documentation/admin-guide/tainted-kernels.rst
@@ -76,6 +76,8 @@ which bits are set::
 
 	$ for i in $(seq 18); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tainted)>>($i-1)&1));done
 
+.. _taint_flags:
+
 Table for decoding tainted state
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
