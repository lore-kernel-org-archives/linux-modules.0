Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B94241691;
	Tue,  8 Jul 2025 20:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752007232; cv=none; b=RhW1/PZsQqJVxGj5zlg3Socvg/GSasW90b+qKH452TUzN1FEQ7VaL6ebtC9SyPeYtRsUQcEvZKqnBa7/oX8I9MSaDLKklX+YU4ZCHPLTitN3X/IETZlWzYTz+hxj9fgHNq/Irn6YjkzvEirl/ZRTNewrYzq+ApuQdr6laTuUo/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752007232; c=relaxed/simple;
	bh=m6W+V+twXVv/UbuD20EaG0kSzRwjYYBbi7LW9Hrjsak=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SYWurznHlQejOqdm0nH50xV1kVMRKGqrq2+RDxoh5YlLpH9lqzl5kHBTreC6Cw5KURXQGvPL8ifmNYWlijJyRVezZGed6V4w3fACvZB3I3oEHBWkctTJfceyRxkzR80ta0IvefJsc1od+75fEQmg1b2ykljVk3496xfLUOKcl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqVTR2ky; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqVTR2ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31747C4CEED;
	Tue,  8 Jul 2025 20:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752007232;
	bh=m6W+V+twXVv/UbuD20EaG0kSzRwjYYBbi7LW9Hrjsak=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=mqVTR2kyN3da2MkV5xAK/ThMyvGHff6+A/MLzbTsk+BgUNQe9tg8c2/FYz9Jz7urj
	 oFuglO39Ff28GVHjlp+m/1p5KeYsJKgmRMVyzpqQil3bJYJ+vJBETdoz6BJr5WIjLi
	 uVVX9Ut14Ada1SmolS2/Ck1C/MC7gaTvTJPQ2ojBELG6z9t/e34nYwz33ky0SV8Ljq
	 kwysMaNjIAocazy01/GMGhpO8TmWZcyEG2d7/g+AZzU+7tWTVjim3QX5GmqbG/j0iI
	 kBuszIheaq5XLxG9qupJWSz0oCmTNtAisITelrAlvnHFaTbWXw5PXqq8AcePZ6vFgD
	 MUJ37YMdPwxCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33ECB380DBEE;
	Tue,  8 Jul 2025 20:40:56 +0000 (UTC)
Subject: Re: [GIT PULL] Modules fixes for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250708193822.45168-1-da.gomez@kernel.org>
References: <20250708193822.45168-1-da.gomez@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250708193822.45168-1-da.gomez@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-6.16-rc6.fixes
X-PR-Tracked-Commit-Id: af1ccf546e5f2915fbbde26841db43a971d81cf3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 72782127388d96e971f0186996a5bd44e64a1665
Message-Id: <175200725487.8458.6473303595373397575.pr-tracker-bot@kernel.org>
Date: Tue, 08 Jul 2025 20:40:54 +0000
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Tue,  8 Jul 2025 21:38:20 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-6.16-rc6.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/72782127388d96e971f0186996a5bd44e64a1665

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
