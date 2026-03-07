Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249B22D7DDB;
	Sat,  7 Mar 2026 09:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772874024; cv=none; b=u9yF4BeoT6OWuwAeRfdTs2ahp0NCxfQG2GS8gOpfvWzeI0fEA2HSboNzf5wzZm8rGJIlUTo/SwCCj/FFRsfKetIDbzIHsoYhIjQPzMBKZDJwEDrK7EhMy4Xpf25zrmqM2EX+74ic8gqcp+QBdwph5HGLjuw3dehwDJnSiQgWJOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772874024; c=relaxed/simple;
	bh=rZDUnuQy7P9XaYnLYn16SJaXfibyQK3FL3f/3cZOGXU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FNL10Put+2IrEuCRml1AyMg95qcfv7rbeBhoY0Tn+/juO85SSBS/wjGoF/AfAMbCSbg6ykyve9CgZZVZJeauQSbgkB/1zM6gBK9eHM5qF2sPndvKj+4Zwajt3BlKhe1dW2OKkTP/rAkhaoe5kBL2RGWBvE+Eqoba6pU07ncdOc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com; spf=none smtp.mailfrom=opensource.nslick.com; dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b=LRjlzkf5; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PeaKTDBk; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=opensource.nslick.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nslick.com header.i=@nslick.com header.b="LRjlzkf5";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PeaKTDBk"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id A2B3C7A026E;
	Sat,  7 Mar 2026 04:00:21 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Sat, 07 Mar 2026 04:00:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nslick.com; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm2; t=1772874021; x=1772960421; bh=Os7er9WYslCoaajGmGRTM
	57xLafy+XkKflJDIrwq9N0=; b=LRjlzkf58uZq9lzJ1m5MK6+Cz0KkwOIezPq6c
	9DJAWQyVeXISNkWPQnwCKu0KP2c5eEGeHgqM7tPFQVctNKtVZd9MQ7g62YPfiWR3
	fQd/oTxfCY1nLtcld+7oINs6v2qOJE7k6pJXNiO7u9PATu7JcJqLMVqWyW4W8pY0
	1GVFJULiMzQLHsJCIIiSQDLSgzR7WqB5hdNYevz8g6psoL7BdJDBIWiLT/1aJuwW
	ZrYOkgu3CZaU2e7Eoat+Vltgdg7l1ZJVe9iMIbMft9xAOXo0nhSrnnYIjCA2Q8iN
	d1ud40ZsFEz6mX6qYqwehA5p2gSqd23g3JMB8BkRSIZXYjYyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772874021; x=1772960421; bh=Os7er9WYslCoaajGmGRTM57xLafy+XkKflJ
	DIrwq9N0=; b=PeaKTDBkC5Ry75jUHCGhzL0vUpENgax/ALb8UFe0Z9o1mve/JAZ
	miNkRwuNG/QNZC1CaIBodJIEOjbgn/pNo0nge9oIJnibLu+xFn3YeDTjm6pu7+Ro
	IDs9hhaEsWoyeRoyVtAYQijoX6oNbXh5qxkue0nokLgbtERSWeraKqgtC5rWntfH
	NTBxcJS2uVdQ8VgV6hVwNJwAWEzRRw1esOIWESPASZQSlOlXl3V3uS9IthKCmk8y
	i7X7SeEbOISmemGRK8a81kRHQWlMZ2j2hJzq7jO0Wco+ZowfE9oVwqsqvTFmj0k+
	QgHYL/k2q126tT7F5f6zdXMz2dDuGOfaOGw==
X-ME-Sender: <xms:IumraZkVXaMwaEXdLITmJZf3IAwsRVfGTYJngO1O1_jfJIJn1YrRJw>
    <xme:IumraRMo9gcbufsoRVVKrq1WauxeTcKGXI9AnwGTeBdgU0QfenW977k7hJ3hVwj_L
    edTl5tpkckpEeHB2jVCMblOjQcYMZwfBRW3-9jZOCYjBN5hYp4t--Q>
X-ME-Received: <xmr:IumraUGzDzrABNZyUv7oRiMh8MQqPuu7TMuTTBd5_-4tATY5c8XolJEZkD4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjedukedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomheppfhitghhohhlrghs
    ucfuihgvlhhitghkihcuoehlihhnuhigsehophgvnhhsohhurhgtvgdrnhhslhhitghkrd
    gtohhmqeenucggtffrrghtthgvrhhnpeduieeuffeguddvuefhteetueeuffevgeekueei
    tedvkeffkeelteefhfehveffvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehlihhnuhigsehophgvnhhsohhurhgtvgdrnhhslhhitghkrdgt
    ohhmpdhnsggprhgtphhtthhopedugedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoh
    epmhgtghhrohhfsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghtrhdrphgrvhhl
    uhesshhushgvrdgtohhmpdhrtghpthhtohepuggrrdhgohhmvgiisehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehsrghmihhtohhlvhgrnhgvnhesghhoohhglhgvrdgtohhmpdhr
    tghpthhtoheprghtohhmlhhinhesrghtohhmlhhinhdrtghomhdprhgtphhtthhopehmrg
    gvnhhnihgthhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinhhf
    rhgruggvrggurdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpdhrtg
    hpthhtohepshhkhhgrnheslhhinhhugihfohhunhgurghtihhonhdrohhrgh
X-ME-Proxy: <xmx:IumraXvN3Pho6LzadnRMWwkL3IE3SxeFlxHGrw7NZJEOHVZ5ich5bg>
    <xmx:IumraUSfyhq6jySZ-916wrYTO4jqu4-rrk5KGKdgNmWr8NsTmae__w>
    <xmx:IumraRMMdFkvkCM3IbQtdqTn3RvVU6E98x2SDVSCxpIJWq7JPgscdA>
    <xmx:IumraS478Yg-M0VprUTp_gxQYcR2KhWc0b3URopc1BbE5XzXXyKMbg>
    <xmx:JemraXwCksR8kvoEOnNNAOs1IzTvE3sBuC6qwRf01Y991PX8OFElgXuQ>
Feedback-ID: i78f146c6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 7 Mar 2026 04:00:13 -0500 (EST)
From: Nicholas Sielicki <linux@opensource.nslick.com>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Daniel Gomez <da.gomez@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>,
	Aaron Tomlin <atomlin@atomlin.com>,
	Matthias Maennich <maennich@google.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-modules@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicholas Sielicki <linux@opensource.nslick.com>
Subject: [PATCH v2 0/2] module: expose imported namespaces via sysfs
Date: Sat,  7 Mar 2026 03:00:08 -0600
Message-ID: <20260307090010.20828-1-linux@opensource.nslick.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add /sys/module/*/import_ns to expose the symbol namespaces imported
by a loaded module.

Changes since v1:
- Simplified commit message to drop unnecessary/incorrect background
- Use .setup/.free callbacks in module_attribute to ensure
  imported_namespaces is NULL-initialized before error paths and
  NULL'd after kfree (Sami)
- Updated KernelVersion to 7.1 in docs for next merge window
