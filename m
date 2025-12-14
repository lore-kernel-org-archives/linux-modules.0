Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697C270575;
	Sun, 14 Dec 2025 20:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765743841; cv=none; b=UqrKN5rjrHuxHxPTOeWHWxweM7yKvUp4karVSgOcXISYrGxnPPRMzShbq4mQkjYLfnh7Q54nP7lYLlwLp0Rr071ZVfAFjG0Vj8W9ZKSYlntBy7o8Wx2pPr/bbYBvgQqSK2+c0sXWBj8u+EO7n3Ph2QOL7XGhGpEmJooOBanFWsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765743841; c=relaxed/simple;
	bh=bWHnczMX4V5FFiTIRvdFJn7prFk6Q9CLUjOr8uJdIBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lEoTDmNTGz4JQhSUn348XZHzeD3Xj+RB5WTEOAkXE7hkGlqXI5V4BasIWVHDefs++kEDkoVll/fXeIsI3+psWyuTnq5DvDL12FQMyimnjCB/EkVudf2LOq7vtzrLRPnjAxJ9YPBUBEn0ft8wTXqFEPDv9PSOlolMO6OZyOnK4VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dPVnpTXa; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dPVnpTXa"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=K19pLdafFW741s/Kto9uQWN4sauI7vl0PzvVNTSPNBw=; b=dPVnpTXax76i4ByP/zBXlNkDJ2
	wmEN9+bF5zJLWvz1Ky1t9Uqyqte02+qSpIrAOX1mvNDCJz1tYQlCjyiJe4+qouhmYTXXx3utDTj6F
	aatlHgVvXRZlu6PBQEaUS2wfO6MT3TfvgNg6VPtGvurrLlPyuhFmJdwdrqrPygoWL5SVShsTx0hXL
	iCyjkgL56akPkmZ/b2Ki/RhAZgIcA6m8Ye+873ZT2prDepa4VFEncwSd8ozWxkFwbcwYPagzCoq2j
	IEtmU2QG5wn8zC7mfKScG3Zl7Q7N/b0dms3LmakOVFIFt9CJ+EY8zYCPEyzPl+mBDAoEpjM8dZc0G
	gJwRq41A==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vUsdM-00000002iTI-0YGt;
	Sun, 14 Dec 2025 20:24:00 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>,
	linux-modules@vger.kernel.org
Subject: [PATCH] modules: moduleparam.h: add kernel-doc comments
Date: Sun, 14 Dec 2025 12:23:57 -0800
Message-ID: <20251214202357.2208303-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing kernel-doc comments to prevent kernel-doc warnings:

Warning: include/linux/moduleparam.h:364 function parameter 'arg' not
 described in '__core_param_cb'
Warning: include/linux/moduleparam.h:395 No description found for return
 value of 'parameq'
Warning: include/linux/moduleparam.h:405 No description found for return
 value of 'parameqn'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: linux-modules@vger.kernel.org
---
 include/linux/moduleparam.h |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- linux-next-20251203.orig/include/linux/moduleparam.h
+++ linux-next-20251203/include/linux/moduleparam.h
@@ -355,8 +355,8 @@ static inline void kernel_param_unlock(s
 /**
  * __core_param_cb - similar like core_param, with a set/get ops instead of type.
  * @name: the name of the cmdline and sysfs parameter (often the same as var)
- * @var: the variable
  * @ops: the set & get operations for this parameter.
+ * @arg: the variable
  * @perm: visibility in sysfs
  *
  * Ideally this should be called 'core_param_cb', but the name has been
@@ -390,7 +390,7 @@ static inline void kernel_param_unlock(s
  * @name1: parameter name 1
  * @name2: parameter name 2
  *
- * Returns true if the two parameter names are equal.
+ * Returns: true if the two parameter names are equal.
  * Dashes (-) are considered equal to underscores (_).
  */
 extern bool parameq(const char *name1, const char *name2);
@@ -402,6 +402,10 @@ extern bool parameq(const char *name1, c
  * @n: the length to compare
  *
  * Similar to parameq(), except it compares @n characters.
+ *
+ * Returns: true if the first @n characters of the two parameter names
+ * are equal.
+ * Dashes (-) are considered equal to underscores (_).
  */
 extern bool parameqn(const char *name1, const char *name2, size_t n);
 
