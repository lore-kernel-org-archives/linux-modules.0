Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE0514E2CB;
	Wed, 21 Aug 2024 17:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724262027; cv=none; b=J7mvbeaI5ZAT5gyI33bhqzpjaPpt3FfMrLR+djHUpanVMN67JZCm2e9DvPOUwevCRprFwgC0CGbVgzLB1YHdbFrF9n7I2ModkrsCDGrM8PGpwQvECZySfLqBjC+S/TGViCsy9RSvGfOgRXxcGHDILPXCIu4u45Ou2L8FSuF2mNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724262027; c=relaxed/simple;
	bh=5J7/T6yzl7KCInG4L9BPvu6uhru8cLsFwgiVNh3iKAY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dxByxKGAet3XyAxCdPmDxRD7kqH8Jsa4jflrU33xaAzn3iPB/hKiaKia6h8EYY7LiaLX1hQ3yYSZ9bNfHDejak3qVIQ8yh+LjWVwbuQTFu4xB+0z0Z2mf48+GcsjmMUVcEJCaS1/DI1MfNQ4umvREnKPyH9ZUwIUzkmu7yxRoqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=d6xroles; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="d6xroles"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=n3kDBkbvNGmhRIVwjhz1rAD3YtvE4/bk7VBRCSiZg/M=; b=d6xroles2VNGsSw7Cuev4NyOrr
	2Sg+zDDW7Ifm9RlFgF6mphephl+Lun2ZuwywRq6I8r3jvJm0CqFucjw39BlYxiCbIk7IZGH/rUTzn
	vFl7Z9yo7i/2QlhYv2pEx9ESI6hvsh8YUCczk9ZGA1Os0PGiwyphFjVh9uy1ahVa9NVFAU4/uj+PF
	Yi44P+wK0fH4tgiK+OerTuvH0TNU2IP19ZiWq7uXZ/yUkAJ49jJwDTgQSQFbb7GHthcWburZ3Yogl
	pBH0w6jDfAT3J8+GyQEhIh6Oyx9o6vJzpUuw8ChHSnBuO2M4XrXUSYFpq+iqpiESahLJdSiaJV052
	Rw4xoyng==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sgpJm-00000009wwx-1HtP;
	Wed, 21 Aug 2024 17:40:22 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com
Cc: mcgrof@kernel.org,
	kris.van.hees@oracle.com
Subject: [PATCH] MAINTAINERS: scale modules with more reviewers
Date: Wed, 21 Aug 2024 10:40:21 -0700
Message-ID: <20240821174021.2371547-1-mcgrof@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Luis Chamberlain <mcgrof@infradead.org>

We're looking to add Rust module support, and I don't speak
Rust yet. The compromise was reached that in order to scale we'd
get volunteers committed from the Rust community willing to review
both Rust and C code for modules so we can ensure we get proper
reviews for both parts of the code and so that we can scale.

Add those who have stepped up to help.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---

First order of business, please help review Kris Van Hees's patches with
Rust in mind!

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f328373463b0..7e2cf251427d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15454,6 +15454,9 @@ F:	include/dt-bindings/clock/mobileye,eyeq5-clk.h
 
 MODULE SUPPORT
 M:	Luis Chamberlain <mcgrof@kernel.org>
+R:	Petr Pavlu <petr.pavlu@suse.com>
+R:	Sami Tolvanen <samitolvanen@google.com>
+R:	Daniel Gomez <da.gomez@samsung.com>
 L:	linux-modules@vger.kernel.org
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
-- 
2.43.0

