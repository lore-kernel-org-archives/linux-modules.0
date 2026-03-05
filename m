Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1097346B5;
	Thu,  5 Mar 2026 02:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772677810; cv=none; b=J7F2j/2B6573EPsHWSyF8CZKvLM510qjFZdvvecxJTsvSxxGSD4lRJcfv5w4M4mGR7gvrrw/h6VMyxWR7mpojP0rcsgpyMdrhpWbNXOdFyKxGadsTCzc8WnvIFlf0MFEZUiym1ydiJMlSGBXaG7iOliqbC0cpqKiqlyfwQiCK6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772677810; c=relaxed/simple;
	bh=6BFjRMJSYzbk6K4pnRx0ihq6YrVqC/HST8KBEcdxeQ4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eInFs3m1Yvy6WNM+7DSgk8edmWSOqinlCnkWpcf9BUxiadBd/6Vve5cqlR1GQUW+9QWRq+RBcZop6XdnA2+mRcO8jSH9CHMQ3WQA6jgEiEpM75B66NA6QCwEktx4l/kZWwgJQNyJ+N9YQp081P/0PATtOo2y+hS/aluP+j/I4YA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRS9HqdD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRS9HqdD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF4B3C4CEF7;
	Thu,  5 Mar 2026 02:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772677809;
	bh=6BFjRMJSYzbk6K4pnRx0ihq6YrVqC/HST8KBEcdxeQ4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=eRS9HqdDEL12cVjpvwMN3U5h+UYke/5E1HwPg1DkKigxAReOGtqoju/CFjLLvHloR
	 aetcu30vpqGSLTDhcDCedWH/weMpsDZkoelG4bGOtnRN7Df8sNj3EQcgGeCI+xkYQr
	 +0dyHTucfnTAgNzG/nl7/yoG8N0N+WPdkMKM4UzBBM3lB40VW0zUNu9tb0aXFyarfF
	 /ManjMNJmNZaHpTNfCc9HeeX3o1crIflndODeKRmG4lZ659Piy/HJXKzDpZHAbkOOP
	 9cLL5YxVjrxgJbJa0uveE/4uSI9yFmFIuhtG1Dl2Yt6Tw8OTTpiH2A9JtrZdwCd5TK
	 Kc9P15KaP8jxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7D0DF3808200;
	Thu,  5 Mar 2026 02:30:11 +0000 (UTC)
Subject: Re: [GIT PULL] Modules fixes for v7.0-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260304232900.149281-2-samitolvanen@google.com>
References: <20260304232900.149281-2-samitolvanen@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260304232900.149281-2-samitolvanen@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.0-rc3.fixes
X-PR-Tracked-Commit-Id: f9d69d5e7bde2295eb7488a56f094ac8f5383b92
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c107785c7e8dbabd1c18301a1c362544b5786282
Message-Id: <177267781004.2484572.2623664404094300464.pr-tracker-bot@kernel.org>
Date: Thu, 05 Mar 2026 02:30:10 +0000
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Daniel Gomez <da.gomez@kernel.org>, Ihor Solodrai <ihor.solodrai@linux.dev>, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Wed,  4 Mar 2026 23:28:58 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.0-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c107785c7e8dbabd1c18301a1c362544b5786282

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
