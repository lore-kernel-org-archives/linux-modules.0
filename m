Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE59F14A088;
	Fri, 15 Nov 2024 12:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675097; cv=none; b=WYqGw09WIvojxq8RFFipX5wpeEVITFytUhL3h6TqAEmPI+uNqIocfa+GTyEaM6PbQfO+Z1SivxxwGozUwOA2gkPeQxm+xRFEUEFwSZIvCcn1dnV1Gp5UoeY8vZU7ciw54BlxrZTmJNVnRDNNPTr5mrBvP9ir6E+1kLTS0nb81Co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675097; c=relaxed/simple;
	bh=ddQo1TKdyjr18X/CX49qvG4aGspREH/6rceHYeVsUPU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kQizJ0x6CY01VjWYHJbiClJNeiDO031j9Rspa/UP7PT24h3HPVGJMfxUCVLTgmgYkUbDZ+JPDHnQ+5PDoHiuY/M+P18tguDhlKjpWEiODLAE9rQSLievjdm1bdX7pu7/afqqfn0mo1WzwaBv7rgXdlv8GlvSvpTnpVti8S07fEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=nlqzezOV; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="nlqzezOV"
Received: from wse.fritz.box (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id C7AC02FC0057;
	Fri, 15 Nov 2024 13:51:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731675087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ddQo1TKdyjr18X/CX49qvG4aGspREH/6rceHYeVsUPU=;
	b=nlqzezOVf3ecOxkGroRnPsOtUfp4g9UdfEqSryjlWismxYqGGJusD/Q5A/TvgtUkvaflaJ
	E7Q04nNJLgN9ngKWNaHMRQi0jgxXAJcFD/W+ZBhn2PRtUIyix88y2HihjkUQ9IhkMmmtbZ
	8xJiefbVyJdVpwHrrLG7kE/o4A3JMeQ=
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
	cs@tuxedo.de
Subject: [PATCH v2 0/2] module: Block some modules by TUXEDO from accessing
Date: Fri, 15 Nov 2024 13:49:38 +0100
Message-ID: <20241115125121.1242871-1-wse@tuxedocomputers.com>
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

