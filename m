Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD0126C10;
	Fri, 15 Nov 2024 18:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731696783; cv=none; b=Ip/lrVlyCU6+0CQhEWzMJZNZ73lb2hb2s0UuLeFz+D29gCac+R4+30xQ4QvC7CBNhv8uSplZSeSrl0Wl3becBUA1cSwCKLrCOtjxkp/LhhjY7vXX6JeHUP70pNFgCFFuEhCjzT4CuNodWmyJby6SIkvx81k2gLi5HL7BBOABe3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731696783; c=relaxed/simple;
	bh=AtAkLePRKh9/bX9140xecAmVMlN9tQpQPW2ioTPTa60=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fu3Gu7i8I96b6gqq8cDroIYWANRIs5Konnd6s1ajG5lUaq7k6Ma3RpnaTSju8Ava2ceIL3GYokFcICBzxJuX9i0Zw06/dFfQXbKKsr/yF87AhAXDvZnGGTnrnuI/jdKgqK2uQQn/KZ81R1oX5ZZ1tnezRwuYfumbcP0LkWcUQ9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=tcV4RMwR; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="tcV4RMwR"
Received: from wse.fritz.box (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 75AE32FC0057;
	Fri, 15 Nov 2024 19:52:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731696777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=AtAkLePRKh9/bX9140xecAmVMlN9tQpQPW2ioTPTa60=;
	b=tcV4RMwRPGhEffemN7jFCOAwz9+KHryQl2Tve3BtUv3axn8KHdrL1Al1GhdYPEPP+fe7W1
	h/lB0pTxwogiwKOSb5kpgEMEui7MYKmUlpmNL1+1PUh3Hk7Olssk64oZQPbKnLa3e4NGC3
	zYudbtPhnrridEtzV9wIQQMXg1th/LA=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: u.kleine-koenig@baylibre.com,
	mcgrof@kernel.org,
	petr.pavlu@suse.com,
	samitolvanen@google.com,
	da.gomez@samsung.com,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux@leemhuis.info,
	vv@tuxedocomputers.com,
	cs@tuxedo.de,
	wse@tuxedocomputers.com
Subject: [PATCH v5 2/2] module: Block a module by TUXEDO from accessing GPL symbols
Date: Fri, 15 Nov 2024 19:50:29 +0100
Message-ID: <20241115185253.1299264-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The situation was less severe then I feared. I'm awaiting replys regarding this: https://gitlab.com/tuxedocomputers/development/packages/tuxedo-drivers/-/merge_requests/17 and this: https://github.com/tuxedocomputers/tuxedo-keyboard/pull/155 (via mail as the GitHub repo is archived).

This is to let upstream know the results of me going through the commits and I hope that this does not get merge without giving us reasonable time to resolve the last module, which would obsolete patch 2/2.

