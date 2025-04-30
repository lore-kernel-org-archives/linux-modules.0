Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042FF289E03;
	Wed, 30 Apr 2025 18:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746036705; cv=none; b=o4Gz8cUfB0077kueaLPBaewr5TpoxyaMjpRDnIGG/Z3hmkHrIW9wHCQimWBxGdf9zrnA78K897vCy63H6lBO6VkmxoKD2xJKDfTbBgeLaQe2covmhYAa9ISOEuVfO65C7mZJrW+mt7WfxsqaR7O7hw2SUrKCdzEhJMU2fG0r3ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746036705; c=relaxed/simple;
	bh=flMWux1Yus1PsgiGUvTD+sqmhFWsupQ2Dgd4GxgCQz4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=jKnScGZw65Y+ndTLejVcybSkykV7E1j2HqxU5i1RofGX3btd5Iz+l4FzchNv5FloSqCIzeNZQGox+kXFeFowo5SsokAQuqa7+L/DDlaItT/mn02qaRXN6BY8QVnyzxlDo2D6m9dqABJhXvzuAVupnt5VF/GxGOttMKFf1y6t9PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tzag1S9C; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tzag1S9C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 720B2C4CEE7;
	Wed, 30 Apr 2025 18:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746036703;
	bh=flMWux1Yus1PsgiGUvTD+sqmhFWsupQ2Dgd4GxgCQz4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=tzag1S9CUvqBxXPSbXuijxnY65hKxOW6jFFtphNuYKKQ6F4GhNSWBqtUGpxKLIQwA
	 puHvl9R0Wqy4HyR9mS/j2Cw3gCoDqwlV3Z0tPm6BA4Aqebrwsh4OcAm3oeOnw0/aMj
	 FhpcL7QQu//GO0nYaYQ/CWlWHo0mUGXsmZQBdcQLcMmLW6795N2X7u75/hgloZnqjX
	 mCTrLbU38DOSb7CGPDEJVayw+5hHaOH+G1nau/Q+v2+oieV1jeSsGtb1JJqGoqtcbs
	 wq74HctnJrxjXIuaycyapwKsBUIBlcGAzNcrwI7+t1MNLFrUiAtuqTET4HdBl/RoHo
	 AkW5kHS9S3WZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADFFC39D60B9;
	Wed, 30 Apr 2025 18:12:23 +0000 (UTC)
Subject: Re: [GIT PULL] Modules fixes for v6.15-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <223a3bc5-0696-4547-b6ca-ab6882510259@suse.com>
References: <223a3bc5-0696-4547-b6ca-ab6882510259@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <223a3bc5-0696-4547-b6ca-ab6882510259@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.15-rc5
X-PR-Tracked-Commit-Id: f95bbfe18512c5c018720468959edac056a17196
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3929527918ffa6a0e5c31004ed06d8d1032fc1cf
Message-Id: <174603674231.2436692.1018201414668187664.pr-tracker-bot@kernel.org>
Date: Wed, 30 Apr 2025 18:12:22 +0000
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Shyam Saini <shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Wed, 30 Apr 2025 15:12:11 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.15-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3929527918ffa6a0e5c31004ed06d8d1032fc1cf

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
