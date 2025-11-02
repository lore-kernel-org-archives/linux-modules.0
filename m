Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DACD27E;
	Sun,  2 Nov 2025 06:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762063504; cv=none; b=jo68sy1Lx70bMUXYCagmVq6uYvYDbZNoaqV3YSUSwujeaWJ5qaaoMV08rl+8YaMilPJVIgFbTola65atXD+hbReP7kYPnaxQUdnfkRmpP8o4b31qvWLXeGBPvGhXWW55n8f4Wgq6MVMC6D3V8tevmMLo3yAe0JI59gjjDGUK9Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762063504; c=relaxed/simple;
	bh=BPArzU6AOY4GRsJQX8Dd8FtZPCg3WUfDh1+BzfqSFUg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FkmWXOSr9MWsZO9Tb4r9PJsdN73q9Ebqvzowsq0nUvzpcdoIVaQ79F3IYOO1OG1XjgcMmlxKzj1zGGdGC1o5I6gcG/ItIL2VQT7WDBdznkdc8bHhRvNxDFuVcGVyLxrDICMJ4zjOwaXboXPru6WSu7/qVCTzX+KzQMtgH6ut+7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BiZPn62W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BiZPn62W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=fvjyzbQzdsv1hb697CTbc+u5e8GxrxFWkjAICgSBNfQ=; b=BiZPn62W3LqoSbwC3vJQ5Jyf68
	LmHMSRp7rNoQgVAg5NnXR04V2peU7fYrc7EB3001ObH6o3LNcqsm6OUCjh7Lf2pthTkBjYPAaAKe9
	frreq8lKz3zOdz7koT6ZMyEKatTQo/fi+rodolzB8zC2k4PmHz1twFsRmEkrAZvBwwrkhqVWGcOeq
	l2jhC2VJAFRYxKGWl3dYVg+JvJA051xT0xf2jy0lCPhB8uD4fL8mrKCAT2rUZ0pZwMjtfB5RMQ8NN
	At4sajFGz9MarHEyfOmvDE1LgRvhOxjOLQk5476M9hn++/OcV/FN97ug168XoHnMs7rmuK1xjm742
	mQkCJzQg==;
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFRD0-00000008KWE-49xc;
	Sun, 02 Nov 2025 06:04:59 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	linux-modules@vger.kernel.org
Subject: [PATCH] docs: ABI: sysfs-module: update modules taint flags
Date: Sat,  1 Nov 2025 23:04:57 -0700
Message-ID: <20251102060458.517911-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing taint flags for loadable modules, as pointed out by
Petr Pavlu [1].

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
[1] https://lore.kernel.org/all/c58152f1-0fbe-4f50-bb61-e2f4c0584025@suse.com/
---
Cc: Petr Pavlu <petr.pavlu@suse.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>
Cc: Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>
Cc: linux-modules@vger.kernel.org
---
 Documentation/ABI/testing/sysfs-module |    2 ++
 1 file changed, 2 insertions(+)

--- linux-next-20251031.orig/Documentation/ABI/testing/sysfs-module
+++ linux-next-20251031/Documentation/ABI/testing/sysfs-module
@@ -59,6 +59,8 @@ Description:	Module taint flags:
 			F   force-loaded module
 			C   staging driver module
 			E   unsigned module
+			K   livepatch module
+			N   in-kernel test module
 			==  =====================
 
 What:		/sys/module/grant_table/parameters/free_per_iteration
