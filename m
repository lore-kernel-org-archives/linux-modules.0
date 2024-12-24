Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1BE212D75;
	Tue, 24 Dec 2024 17:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061392; cv=none; b=JdKIJU4JfGYXIhHJAoPUsmEba3+kkNxArbhLwTwuptUo+kf33wbCakrHTEJ1QwQnbOeG6x/kdvwbyKmJyIOM6K42QJBebuC/sgZPCss2AwQgHoaaIlYC5y2Rmxd7TfhWuaVNpn3zHoOH2ID4Un0woAEIJGkKJhQYprhCGy6QKyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061392; c=relaxed/simple;
	bh=phhf35B31kK98Vgz6hVplqQPi5UpGvFRCxrr6RUKcI4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Gqbjo73pPCizEReXlCdJkVDRrYwT0HV1Ya11FtBnRhzqlfjIPHY2NeN0gbdVbhgd3+vPgCHUkWXHQ0N6zZ7Q48vSM7jU4ciMGZ4ULUK6YPcQwnqusFOoy/Pls+S2CGSA//CfEpQh5BWEUK2SSbZ3lZaZEUbzrt1OkR+Cw+7rrIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uaxQFylV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uaxQFylV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3B5C4CED7;
	Tue, 24 Dec 2024 17:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735061392;
	bh=phhf35B31kK98Vgz6hVplqQPi5UpGvFRCxrr6RUKcI4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=uaxQFylVW02Elp2xjSKrGym80cfxqqyVCSz84veIK+FkyK2pesi2PyA+hniHefi1j
	 5kHM8z2Q0/5qTQIKzuXmiZAxge7JDcD69EGNeQZyaQQ9TgXBPFjMz6BmnX5wEyDoCH
	 VsCXKO9G63vpxWyYPcxE/NBjSbuHQloHrvYMk2653GzStj/E3iCaI++XS195//QL+Q
	 A59MJH7FIAvo4UXhLbCcIQ9pAexTexC5/lE0VBlHembWpBpThLqYOuBpxN9+eQ8xHB
	 vk9fJSGCFSncAH72Q7CI+UglHdY/1LZQA7lrqsxHPpxra2CFZC1y2Q7/qlFQkvvaJL
	 5BF3P0SD7KISA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 73A32380A955;
	Tue, 24 Dec 2024 17:30:12 +0000 (UTC)
Subject: Re: [GIT PULL] Modules fixes for v6.14-rc5
From: pr-tracker-bot@kernel.org
In-Reply-To: <fedd0c6b-a870-4b8f-8f52-6e11df936678@suse.com>
References: <fedd0c6b-a870-4b8f-8f52-6e11df936678@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <fedd0c6b-a870-4b8f-8f52-6e11df936678@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.13-rc5
X-PR-Tracked-Commit-Id: 0b7a66a2c864859fbf9bb16229c03172eef02c05
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ef49c460ab89d3d0ccc01c0ac3b55a47927ec6d5
Message-Id: <173506141095.4160820.961831018391178078.pr-tracker-bot@kernel.org>
Date: Tue, 24 Dec 2024 17:30:10 +0000
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 23 Dec 2024 11:55:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.13-rc5

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ef49c460ab89d3d0ccc01c0ac3b55a47927ec6d5

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
