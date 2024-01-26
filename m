Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E771C2AE
	for <linux-modules@vger.kernel.org>; Fri, 26 Jan 2024 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280230; cv=none; b=eOeUDr9c8Va9LiMPmmCHgCZHIKPkYBx2UTa5Bd5S98xkBxnpQ6d3E+pHIlV7wklSZCgHff+NgfAE8lykhHDRglszj6/j4zD/Q5+1wMQeO7qZTKrFvGH5njiXc3EgTJg4AXsI0n2dsnCCMWboki/8t2PwhFKZbhJqGOgxfuRtg/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280230; c=relaxed/simple;
	bh=Mwkjxdv6ZeI3RiGnQHQaNJvZizkxUrEbM4PzHrmVAGg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KfasZusfbUprLtZUd9x94jjLKYe4y0LzoRBvsuOiFkEeZhOZKgd+haptVFrPu1NDt3tZY3iUxYzXp0MhRxUV4323w/qLuBw79jmLHFBjbrJ+iG2IkbKMgfdhvfY0R4eHZylBrY7rpakQyXr4J2ex8rZOaxVZhjzoW2eJ3oioTn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y9r7WpcW; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y9r7WpcW"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9E7FAC433B1;
	Fri, 26 Jan 2024 14:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706280229;
	bh=Mwkjxdv6ZeI3RiGnQHQaNJvZizkxUrEbM4PzHrmVAGg=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=Y9r7WpcWmn7DIroDKzL7ufLk/AIsrN4rG7oBOT7ymGQFqsAopdQ1OZvwiKn3v8gyv
	 QnXJnW4n2xKNTk+/ryuMCtaFbmfYMAPk9W7IykP0t4gWp+XzpdBbk59UIZ70pR0+xK
	 5k5glQzKVwrcMDLGzzoKccnOWwTJBMBli5WLNeqDVo3vlZ6TfdAsCgIUjQyDm2iRNO
	 cjmtWzuoOmZ4XJzycppwkozWcEp8CaAddqVBLHA/Y7v+DMlINUjiwIxIOwBC1ade1n
	 lqlx2POZEMRDlJi6ec0AVk9FRuxa59EYXmZpNoxMh6acQbL7f+FV/c+FhY9179MNPp
	 0uCZWPesxd9SQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88282C47DDF;
	Fri, 26 Jan 2024 14:43:49 +0000 (UTC)
From: Emil Velikov via B4 Relay <devnull+emil.l.velikov.gmail.com@kernel.org>
Subject: [PATCH 0/2] Polish module_directory help string, install symlinks
Date: Fri, 26 Jan 2024 14:43:49 +0000
Message-Id: <20240126-master-v1-0-6257d039a30a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACXFs2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDQyMz3dzE4pLUIl3TpEQjC7MkI7PU1BQloOKCotS0zAqwQdGxtbUAqZF
 WblgAAAA=
To: linux-modules@vger.kernel.org
Cc: Emil Velikov <emil.velikov@collabora.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706280230; l=807;
 i=emil.l.velikov@gmail.com; s=20230301; h=from:subject:message-id;
 bh=Mwkjxdv6ZeI3RiGnQHQaNJvZizkxUrEbM4PzHrmVAGg=;
 b=owKXjQXevkD2k1BGeCmO+DPuJb+42URVekX0+uJqqAGxlaTkGo661qCftIJaRPj57Fbr07FD7
 hhY0BmaCUZ/DBUpVWRfoRGUUUZyedan1RNwvsKNrFMRC5vMPR2AqINq
X-Developer-Key: i=emil.l.velikov@gmail.com; a=ed25519;
 pk=qeUTVTNyI3rcR2CfNNWsloTihgzmtbZo98GdxwZKCkY=
X-Endpoint-Received:
 by B4 Relay for emil.l.velikov@gmail.com/20230301 with auth_id=35
X-Original-From: Emil Velikov <emil.l.velikov@gmail.com>
Reply-To: <emil.l.velikov@gmail.com>

Hello all,

I've noticed the recent module_directory work and I'm super hyped to see
it released. Are there any plans for v32?

This tiny series has two patches:
 - tweaks the help string for the module_directory toggle
 - installs the insmod, rmmod, lsmod ... symlinks

The above should be fairly straightforward, but if there's any questions
or concerns do let me know.

Thanks
Emil

---
Emil Velikov (2):
      configure: tweak the module_directory help string
      make: install/uninstall tools symlinks to kmod

 Makefile.am  | 10 ++++++++++
 configure.ac |  2 +-
 2 files changed, 11 insertions(+), 1 deletion(-)
---
base-commit: 48b0c75f79f86140314b9656d3d855a515e18a73
change-id: 20240126-master-5ba286b26eed

Best regards,
-- 
Emil Velikov <emil.l.velikov@gmail.com>

