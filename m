Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792785478;
	b=O7yDdONePmFAjTECrOEM86R4mN3I7cDrEpQ00nD6Zfaww9OSG76tQhFU6AgFvMrNReDi
	 yHvtSYmW+j2Jr3/KVZ6JWKqww8QR7iSXVRN1CBQ7F+WfiiVcqHh+qjxRJBqZbeg9aqSqW
	 4bXNUjxWptO5eORVG6joyuRNwPD1DFkM0vFZY9JYmPQ+Ro/6YM8MJsq2iUuLN/8JpPsMl
	 xZCWRsejo0hIahoCflQ2Omi5YTQm6Mo+eyyz2sFNE2HaeKkeEHJbDPKtKBT5gx48ZExAq
	 iSz6SLqu2kp2ujvP0o0AKZLBnvo8x0d4M3MhZrMuvM4TyT212OHA2oIOGqSLR0aUSjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792785478;
	h=Received:DKIM-Signature:Received:Subject:From:In-Reply-To:References:
	 X-PR-Tracked-List-Id:X-PR-Tracked-Message-Id:X-PR-Tracked-Remote:
	 X-PR-Tracked-Commit-Id:X-PR-Merge-Tree:X-PR-Merge-Refname:
	 X-PR-Merge-Commit-Id:Message-Id:Date:To:Cc;
	bh=EH0xSRDwUfhPuI+LpfNJ6b7nM9CNYg/xB+CmsbrnThc=;
	b=znDOiljMzc/Q4EAOPwiAg9Mu/7Z06A+7KEF2M4AqUONJhdW/j86T+lQWeLglQROyzjTI
	 pmOYW/3V5Dr1ao2nPEtutXFWlURIbscNMt7ZMvmGXPBpEt9lfQoUk9+aV43XkmCW1nuvY
	 PhPQIq91kGOFdWP8UFQhU552AC+5ktGvNeV8Yo43GFhTY/RGDm2Ar87XkMUx9ZozgeP3+
	 eFDukdcZ5DI2QaDF2UcLjunUlVyirfYSMMnj26Pw56aBWUPgMCE6t+NQJfA07xvCj5gKB
	 OSUhCxeaK5gAOemdm04s3eKf7Fv3yUARbDdFnD69nwGoAuatqVSmo80FE3/8RuRKjWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5ud8qGJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C19606A336;
	Fri, 23 Oct 2026 19:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V5ud8qGJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C79FC1F031E0;
	Fri, 23 Oct 2026 19:57:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792785477;
	bh=EH0xSRDwUfhPuI+LpfNJ6b7nM9CNYg/xB+CmsbrnThc=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=V5ud8qGJ+F7HZqIBf3qjelaB359ezWja4oRR7B78Yh204q5IV1sn6vUZGa712NOT6
	 EApJ/DW9RNqSREyhflJqEAZHIgYJ9mNP7KbosX9X16knrbIMOuuqTh5WwHb2atACen
	 WNaNWHChae38/lg3SZEJx43XqhF7HkP7tNFB8fvLDUhyBottgSAphEp3yf+1LlXKf9
	 IPPJyPqq0MAbT2yTSRz0bHHo6vosI1Z2RfNVXbbWouLAB8bey9OupoGmcwTrMqUec3
	 U+dNYjUVARMdrgQOgAy+Onw3CtILHkciaqgKGpEmPIycSUAGTK6G9UQ6jHRNmgi3jN
	 bExwRhM4/A7yA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BE90B391B153;
	Fri, 23 Oct 2026 19:57:57 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v7.4-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <71c66d25-389b-4d28-b031-1d7d5261decf@suse.com>
References: <71c66d25-389b-4d28-b031-1d7d5261decf@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <71c66d25-389b-4d28-b031-1d7d5261decf@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-7.4-rc1
X-PR-Tracked-Commit-Id: 08abfa5a161e1b6e6244cb2090b0530bc0920798
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c0e8d301378775e6e1946389f3ff621f8601fa85
Message-Id: <179278547647.1241373.10110966753727086273.pr-tracker-bot@kernel.org>
Date: Fri, 23 Oct 2026 19:57:56 +0000
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Tiezhu Yang <yangtiezhu@loongson.cn>, Kees Cook <kees+treewide@kernel.org>, Priya Bala Govindasamy <pgovind2@uci.edu>, Binbin Deng <18983559317@163.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list

The pull request you sent on Tue, 20 Oct 2026 10:46:14 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-7.4-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c0e8d301378775e6e1946389f3ff621f8601fa85

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
