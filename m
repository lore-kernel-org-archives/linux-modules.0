Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E902E6CB8;
	Wed, 17 Jun 2026 11:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781695552; cv=none; b=o4ulMXmQjPcKYuAU4jP010x/PWS/iatEKdyph63c+vcpO2QO6Ii1Xr44k99mLcNfYakxLi5uledK0xYNIZP2DuTSqSPQ91fqGg5WgMH1cEyqHqWg287gXK8x9K4m57lCV6ER4QhyMgNIxY5GfDnTNSnZbbaccfK9kpSLcVe1F4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781695552; c=relaxed/simple;
	bh=TiRkFSxjzcq+JZkNP6D4wveWX7xNe4eFRX/M63R1IsA=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=geIyfa8QGMPOWWBH9pzx2bE8iuUw+u3UxH67HL/6RT+5lazIFEVsZJ0hA4cWHvJRVl2u22Vdq3/w6mNGocyZ/InvjtXiy3VuXAyt+97WJaV4hqPMZCAfCy7ltZEdnbHx26sqMhTbQxPbPOOXP7FKPKAXA5ZIqHCy8TZd7/lR5TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YUsi1M9Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YUsi1M9Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D414A1F000E9;
	Wed, 17 Jun 2026 11:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781695551;
	bh=mvOfWBXOpMFMFGWhQV5TvD7E5GMIfbXKbrd0KtXv95c=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=YUsi1M9ZGmwm52O3J4Bc+2g0DHVUASw/WRuAtWMDNYlRhfUZjeWvnrWMYVpMlIg8E
	 8tuJ/hMoiDCTw3DAhvt1MPqIS+R9wMJVjn2ImPFxifbQhhu8t2LxO84ZzvxkNzPpph
	 OeXGjPnrrqXN0A6X2RB2OfojXzNdhZbU0TgOnSFlDkC362mDCD4L/4mXhl0gik3dSE
	 RPuKH0gMiS1JuKWig31nk4BnLLUViCO+ESXHd+CNzvNOJhvoE3BmY8Gx+l2Prkhy5U
	 /DX0V5WFkUK24PnrjNnrur2YWB+8NjM2uSuDqS2KAzzpFHRGSWOCVqccmvXCudB06+
	 SoELatlON/Ndg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 39EC33930E03;
	Wed, 17 Jun 2026 11:25:47 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v7.2-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260615155518.3644770-2-samitolvanen@google.com>
References: <20260615155518.3644770-2-samitolvanen@google.com>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260615155518.3644770-2-samitolvanen@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.2-rc1
X-PR-Tracked-Commit-Id: 36d6b929bb0c7cc1cc742d9b5805537d3b651094
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8479bb8c44fdabe3d123735347af95002828d112
Message-Id: <178169554599.1566750.15992486300233025100.pr-tracker-bot@kernel.org>
Date: Wed, 17 Jun 2026 11:25:45 +0000
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Andreas Hindborg <a.hindborg@kernel.org>, Andrii Kuchmenko <capyenglishlite@gmail.com>, Daniel Gomez <da.gomez@kernel.org>, Kenny Glowner <sisyphuscode0311@gmail.com>, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 15 Jun 2026 15:55:17 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.2-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8479bb8c44fdabe3d123735347af95002828d112

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
