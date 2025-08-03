Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E6020E023;
	Sun,  3 Aug 2025 22:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754260362; cv=none; b=M1m/SZP3H20kjFBSbCntVEf7UI+m9IRUkOB3FBIy57PmFpUBBV5DXwHeINPcQP9k8T8vicJ7g523JFYvZkH5UWN/gzMAEYjwpJbNuIeFRjACkej9J8TYT8tK6Scr4sfqqeozmN0hA2ynDIc3mDd7zqSoQ+NoSsDERIKsRD1ldvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754260362; c=relaxed/simple;
	bh=aVdVLe2MqCOblcMX5g4YyT9zisX8qq2CyNH72vFiA18=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=RcEBY8TqcT/MXLGy4XunPKQwkEi92G0pIbm7Pk6eNOYWWpn5Ir7pw25fk1mj8DRJsoG6FmVQCNekd+P2O4CIgMbo7FpOFvlDN8EE94vnSjgI7racoyU0u1JgouUHfKXlp6aC7n9nCcWRAVeAmpQOQDscqaKiiMogWHZePXzuXCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtBhnb0v; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtBhnb0v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12684C4CEEB;
	Sun,  3 Aug 2025 22:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754260362;
	bh=aVdVLe2MqCOblcMX5g4YyT9zisX8qq2CyNH72vFiA18=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=UtBhnb0vR2XlgtV4L+wgpOFJhe+0piLwghxvRXWAstQQlmrhtr2iENZRPKH8QlW/G
	 CKaTS/huh4bMsFRVus+k1w9mlrrmwEt+GCA0/JyjxZoXi1F/myeVFn8/a0rtq5iGRi
	 j16MadUltPq6OxP/ezzvwVCiLEWgqqhf7uWbI43FMzuP8zv3pRmYAKm7fjrygXvqxe
	 8QrUoXMSsCw9DCtv8P0s+PP9zXgDdUjT5eLNXkXXNH9EJRT43LWID5Wnas6sji2q6Q
	 Emj9Jo8TX4DSZsWCuyt0X00RK84Q/i6p1OKHRS73fL/nW4zi+LLaKWRoXG5jrQJaak
	 /l2488zc10kcA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE6A383BF56;
	Sun,  3 Aug 2025 22:32:57 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.17-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250803131809.4890-1-da.gomez@kernel.org>
References: <20250803131809.4890-1-da.gomez@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250803131809.4890-1-da.gomez@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.17-rc1
X-PR-Tracked-Commit-Id: 40a826bd6c82ae45cfd3a19cd2a60a10f56b74c0
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8877fcb70fd7ae0a4d5ac73d250dc255f7ff5a2c
Message-Id: <175426037654.556955.16092172592387980014.pr-tracker-bot@kernel.org>
Date: Sun, 03 Aug 2025 22:32:56 +0000
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, David Gow <davidgow@google.com>, Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Sun,  3 Aug 2025 15:18:07 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.17-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8877fcb70fd7ae0a4d5ac73d250dc255f7ff5a2c

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
