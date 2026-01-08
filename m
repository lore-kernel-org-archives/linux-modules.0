Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D53267B02;
	Thu,  8 Jan 2026 04:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767847677; cv=none; b=PsFe/IIC9g1gBY02dyF4eVXu/JoUHDzdlFDSBfQEAoXw8FNauTWVe6JRdPqxVqNtoaMNE44iv5uWEXAxJ+ngtjseiocKGotAEPMOhKpy2/nn/BzOfz4cpSDjcgmTUt0z+nfPeTq/6S4HCqwyPYzB4tzLkLK4CNQpXDhOLhB+ewM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767847677; c=relaxed/simple;
	bh=2jZm+azm/zsvNCujFw2oLr2iuAT6NNn4ixcf+icxfys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4FFHSxjii4gHY7Be7SZTMARyDzaKSukJL8TgiQmCyjRmxHeKJnjXg2Sl1HmPoVUGYId2uCRBbWHLcSfGtHK6BZoxf5lEO6D5Z/FUClqnlRN9ZhgN1iKLR/CAc3xOsY6N19UBd5EaAjIDwOcCydTLHYF563maE2hg+g0OYejP1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com; spf=none smtp.mailfrom=opensource.nslick.com; dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b=fZSAD1DG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=V+3PgdGA; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b="fZSAD1DG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="V+3PgdGA"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3045B1400044;
	Wed,  7 Jan 2026 23:47:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Wed, 07 Jan 2026 23:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nslick.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1767847675; x=
	1767934075; bh=pOGD/XYAtiEgZSmm3oioBf0YdBeQVCdG6rkQiT5fg80=; b=f
	ZSAD1DGLpR8G3WGEedlOjpAbOwIdQfrpj0CrBMFeSZJO/I5BhY+UU9/HDciyQAor
	PTjRZsqMbtaWDTq+n3ghD3BJbTeh2Z9PfvHZPQveasBB5OY896uZdrzHabEtQqVE
	ol0RXb87QqEHJxgUOdaLAxVEVDwwwQ6GPBnFCneKuSGTxmKE7fJ5MgQUwls9ahwg
	qbTguQ5Xe0wOk7atiVqaRseG1g/h9O5b9WUNYSrHY0VPuVIDTX1cGD3SvVUUi20X
	oF23xo7/Vnl9RJIv0st8OZ8o51iemvmiwTyIHDTUeBHuYrXjlkE9U4qr3phPU6jb
	MWHgL9NvgfCgyR8KNlxHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm2; t=1767847675; x=1767934075; bh=p
	OGD/XYAtiEgZSmm3oioBf0YdBeQVCdG6rkQiT5fg80=; b=V+3PgdGAascE1H1vf
	nYTFUI3Qhv9nQqnMNYMMsa1N3eLvHJr3Ddm/mUswJHy9kV6ubiAfi6otUwqLrTN8
	LB9jHtJs+Bjp+nOhgvcIN33e/Fv5NhIctEPJl5Pe4qotgaVZQXKb/XKDTjmKFpgs
	bHY4tfZsi1z5l1IQGr5aG3FtYvKvltI5tRk5X8HGCM06BfLFUnjRcTq3mat13J/Q
	LbJ8/+LYhNTT7LaVGxPk0SFbfFfVYr8tTfM+/63ls9Xe1SiTgesXHVqV/X+tHDSs
	8KXaDs3H6R5ik2EzJypR423y01H9QgW9pYMbt+nxH9SNEG91WIAbpmugiQF7ycEc
	iNaQQ==
X-ME-Sender: <xms:-zZfaTJqqfJNkq1F3NvphV01JzlNe-Z50-83rvoTXj2TaTOgVjLA9w>
    <xme:-zZfaSk17MhuJefc4HHHZfmLF0IoRufGT4ei4g_-8rlu7Xv7JcIFTG3FQFJX670uA
    cyMQPtxQZEVfLk3UssKsKGS6n3ugQdxibgvfidAujjIDvRBT-9YNQ>
X-ME-Received: <xmr:-zZfaaaeEqSja-oR_a5P1QsAIkctLa87SOi0Vpge2VcbBlfKmcM5XcJbxegWn-nSS7RBHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdehtdefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomheppfhitghhohhl
    rghsucfuihgvlhhitghkihcuoehlihhnuhigsehophgvnhhsohhurhgtvgdrnhhslhhitg
    hkrdgtohhmqeenucggtffrrghtthgvrhhnpeetudevkeeuvefghfetleehkeegudeigfel
    gffhtedvkeevgfekueelfeevfeelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehlihhnuhigsehophgvnhhsohhurhgtvgdrnhhslhhitghk
    rdgtohhmpdhnsggprhgtphhtthhopedvgedpmhhouggvpehsmhhtphhouhhtpdhrtghpth
    htohepmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtrhdrphgr
    vhhluhesshhushgvrdgtohhmpdhrtghpthhtohepuggrrdhgohhmvgiisehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehsrghmihhtohhlvhgrnhgvnhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtoheprghtohhmlhhinhesrghtohhmlhhinhdrtghomhdprhgtphhtthhope
    hmrggvnhhnihgthhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehi
    nhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpd
    hrtghpthhtoheprhguuhhnlhgrphesihhnfhhrrgguvggrugdrohhrgh
X-ME-Proxy: <xmx:-zZfaZjfICS5NMPlpwOCKVbMDQG_ckWCmloWheJQJCAwAe4DEuuupQ>
    <xmx:-zZfaQwQTAPAkxEC6oLRgYk8PbbOpYfeIGSNkfriKTDYlkA1fBLEJA>
    <xmx:-zZfaV84OoRSnLCqP0rIakhKVz1EVnKTNDKN5f4bLTTz8olXKdjNMA>
    <xmx:-zZfaVwLAvKYf9BK5p7w8G8HYGvOMxDvoP3iJpZk9AqdPI_5f0FZ_Q>
    <xmx:-zZfaeYECRuDSlBOuafuRw92U2k7RJTCmAvn5KYQEddRrpJzTV2ddhrr>
Feedback-ID: i78f146c6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 23:47:53 -0500 (EST)
From: Nicholas Sielicki <linux@opensource.nslick.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Matthias Maennich <maennich@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicholas Sielicki <linux@opensource.nslick.com>
Subject: [PATCH 2/2] docs: symbol-namespaces: mention sysfs attribute
Date: Wed,  7 Jan 2026 22:47:10 -0600
Message-ID: <20260108044710.33036-2-linux@opensource.nslick.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108044710.33036-1-linux@opensource.nslick.com>
References: <20260108044710.33036-1-linux@opensource.nslick.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reference the new /sys/module/*/import_ns sysfs attribute in docs as an
alternative to modinfo for inspecting imported namespaces of loaded
modules.

Signed-off-by: Nicholas Sielicki <linux@opensource.nslick.com>
---
 Documentation/core-api/symbol-namespaces.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/core-api/symbol-namespaces.rst b/Documentation/core-api/symbol-namespaces.rst
index 034898e81ba2..2304d5bffcce 100644
--- a/Documentation/core-api/symbol-namespaces.rst
+++ b/Documentation/core-api/symbol-namespaces.rst
@@ -114,6 +114,11 @@ inspected with modinfo::
 	import_ns:      USB_STORAGE
 	[...]
 
+For modules that are currently loaded, imported namespaces are also available
+via sysfs::
+
+	$ cat /sys/module/ums_karma/import_ns
+	USB_STORAGE
 
 It is advisable to add the MODULE_IMPORT_NS() statement close to other module
 metadata definitions like MODULE_AUTHOR() or MODULE_LICENSE().
-- 
2.52.0

