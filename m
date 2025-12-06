Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3EC31DDC2C;
	Sat,  6 Dec 2025 17:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765041935; cv=none; b=HsEspbmQR+S2WCgvbU4cli9WWQl0iUd4Sj60zO9XE6RdKe0i7fqKb2Mc8JonDO2I4D3ZBdGB2GQ0b8gW5hvaMvpyVPXhXEzOb8t9p4S56vabWRQSsXTFgqfP67Dzwjvu1VrHJZpLCExbunz42MPe7NXfTUBX044y35wnINiKYIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765041935; c=relaxed/simple;
	bh=Uyh8oNSUwlDNf7tdMzd1TLKR76W9+Uj6WuCLHAL91us=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tnL7Demit4zpMqZ5UsAG9np+WxEwYVh6chorFn7WIedIeagmSCeyXCZz78U8EK1e+cazT1Su5woa/WEcoGPWEvbEy2lP4FO8UYaSWr5Jz2wVh53s5RRfVsUi+tfAsjd+6iD+M6lAYJb3ezhBs7xEHrnue+ErB/r1N+N+6eSXySM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEBO4iuA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEBO4iuA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 414CFC4CEF5;
	Sat,  6 Dec 2025 17:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765041935;
	bh=Uyh8oNSUwlDNf7tdMzd1TLKR76W9+Uj6WuCLHAL91us=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=WEBO4iuAMAi6+fdWqSzAou00r1O2LG/Lf+JHtd4zsq40ZZ7VgMJPtE19vNpwUb+L2
	 7KhPzToPyfo66wRqfhYwawo9cd4Rv7j9COOa6IlblHOpxNOMAUbm75YdPcBrivtFhe
	 QILLnpTckJaZr5+ee1ECBBXUlatSrcmHIMERJsS50EjSmTShACF2T4aDP7sEPBpE+e
	 1RPld5yjoi/tironXpxvj5K4bCKIVM7MdS83OFMlfLxUX0RPmFwqKh8Fi0WaDYW0V3
	 jaA3bMtEFDZmq9FIBZCMFUeJS8/QgtunMwh1gJORRAoz2FkLYIuuAuIAVdkeDlUTzj
	 2LlJtyzlbfgtA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78B193808200;
	Sat,  6 Dec 2025 17:22:33 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.19-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20251203234840.3720-1-da.gomez@kernel.org>
References: <20251203234840.3720-1-da.gomez@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20251203234840.3720-1-da.gomez@kernel.org>
X-PR-Tracked-Remote: ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.19-rc1
X-PR-Tracked-Commit-Id: 1ddac5cd7f278345b2e8298c930e4bffe0911a45
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c84d574698bad2c02aad506dfe712f83cbe3b771
Message-Id: <176504175220.2143352.5370592392691833644.pr-tracker-bot@kernel.org>
Date: Sat, 06 Dec 2025 17:22:32 +0000
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Hans Verkuil <hverkuil@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>, Aaron Tomlin <atomlin@atomlin.com>, Kees Cook <kees@kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Thu,  4 Dec 2025 00:48:37 +0100:

> ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.19-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c84d574698bad2c02aad506dfe712f83cbe3b771

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
