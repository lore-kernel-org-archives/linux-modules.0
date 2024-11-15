Received: from mail.tuxedocomputers.com (mail.tuxedocomputers.com [157.90.84.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E91CA5B;
	Fri, 15 Nov 2024 13:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.90.84.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731675706; cv=none; b=sCT3xYYz/rcMgPNia5HooGAju6vtrQB0TyWrBoDwYZdCUMPjsJqtEyGX+4B3GDGHQmOAM4FUsE1PFWgCuKuFYaZunpsHlYAk8TXSJpiv93VV5VLiojmK5/AGoBi7Dg8OzcJyQ2cvUFQL1utgpXbjdH6Rz9qj0jXo9hU0Agmt5TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731675706; c=relaxed/simple;
	bh=Nd/y1r0tJv1gaSpug4h+jV91RrNIbFMcDYpPAFggicY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=R/l+pVRurihWEwZbuychcNb9ck/3IVrKvtlhh0aCCRY1BpG66ohprGUb2Hn619tln/fT4AmnJomyOwdSH5ZyVy5xhqiFN9z+QQehbQHjm1vU4ou99spDNeS/XWOx8RIowO1wYTD8WyruxpbBQsjzy1H4SncmlJiud8mgiEI3Muw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com; spf=pass smtp.mailfrom=tuxedocomputers.com; dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b=bumJKENX; arc=none smtp.client-ip=157.90.84.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxedocomputers.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tuxedocomputers.com header.i=@tuxedocomputers.com header.b="bumJKENX"
Received: from wse.fritz.box (p5de457db.dip0.t-ipconnect.de [93.228.87.219])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 1B2A32FC0059;
	Fri, 15 Nov 2024 14:01:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1731675701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Nd/y1r0tJv1gaSpug4h+jV91RrNIbFMcDYpPAFggicY=;
	b=bumJKENXQSxj7VFAtb5U/ECd+LtJiAJ7hWjYYbAQMFDOfNaYbeLyg/0WZu6dirnw2maQK3
	7DpsRo0Hd6s4geHXjE4gxmSshX//GwQAZyB95XRu+cHp9qdpsWP/vCOeVKS8U2NVD7ymoF
	MaWcRyp473f0mLmopYWmUZ6JJggm8os=
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
Subject: [PATCH v2 0/2] module: Block some modules by TUXEDO from accessing
Date: Fri, 15 Nov 2024 13:58:40 +0100
Message-ID: <20241115130139.1244786-1-wse@tuxedocomputers.com>
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

