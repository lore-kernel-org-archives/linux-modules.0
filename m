Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466AF1BD507;
	Fri, 15 Nov 2024 16:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731686800; cv=none; b=RLXshFyvzKNEOsWldf2pZUIIk0sHS776thA3JRB/BgLG5j5s17ziy8cUuZxAJbHpejnbJqFAmonX1xLRBgw7xJv1DOybR6TujD4Tr/R2QTdWy7ZBQ7moH0o+UooAaR0KITaSLAuzxtceAvxdW8/8o0JkP9sWqkGLUJ0R4bn5Aus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731686800; c=relaxed/simple;
	bh=19U31l/pyjJUsdCKAe0qth1Evx2MEL+UGfFLPTPHef4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VyYUHjsqnoKxn0U5kyXUphl0ZXEUnumw1T91yh0j8EFhr3jXRZfX4oA9uMvel6hIsb6Zt3qXKqgFNt6kqzZe2ZnEcvxnV3WO+rMm+jXEdq7Izcz3Z9gO5BQQQrPmGGtpLgoweY/Xo9UOhRkYw7A/SrRfReuLZ89b+7s8b41Dp98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=i5WN1xHy; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="i5WN1xHy"
Received: from wse.fritz.box (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 699342FC0055;
	Fri, 15 Nov 2024 17:06:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731686796;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=19U31l/pyjJUsdCKAe0qth1Evx2MEL+UGfFLPTPHef4=;
	b=i5WN1xHyrtkYUjbVQKAE4HN4kHbXdWpk9liHyd5C6C1ImMuT9aiO+NORwZxkvnP1Ddz/PP
	Q+VhB3Z4gRZRGA/t9oH/aCJRvXjczN8ONKtmv9mB8qAQ/QU64xwwIfHm3AQur3tgoj0g/S
	AeHY8h7L3mNgesZcKkSQhVsKv5OsjR4=
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
Subject: [PATCH v4 0/2] module: Block some modules by TUXEDO from accessing
Date: Fri, 15 Nov 2024 17:04:35 +0100
Message-ID: <20241115160633.1271757-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Following the meeting I wrote about yesterday, I now changed the license
of what we could change spontaniously to prove good faith.

I still hope that the rest can be sorted out before anything gets merged.
We are working on it. A clear time window would still be helpfull.

At Uwe. I don't know how it works if you modifiy someone elses code. I
removed the Signed-off-by: line and I guess you have to add it again?

v2: Removed modules that could and have been spontaniously relicensed
v3: Fix typo and remove untrue assumption while giving more context
v4: Actually commit the changes I made for v3

