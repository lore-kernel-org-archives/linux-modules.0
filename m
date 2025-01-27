Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D43A2AF14;
	Mon, 27 Jan 2025 00:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737938089; cv=none; b=r51ibE8OMCc6oZB6J6M5vmLHkgFcqwFK8vLFlNxa3DezgwDuQWHKG/CnyCIIGN+AnhfRJ0ars1f9AgP7Ong7wtsxGajiY4GPa+okPBU1V+OaZuiTymNkTAyuJbT5F/SToQ6z25knIbuHTzdTv6RHd/nausTaal6KfQj3hKpugtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737938089; c=relaxed/simple;
	bh=KMdR3zEkNFzgtlBkobZBQzYlqXu9ohhKXNa9kVW7YcQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=mORv5dwV4VgRarUjBK010HJHuQ3tZQ+ZkM3E4uYFPpZ7FMqZTJl/Ua+TvE3nHDFKN3+UJXn5HxafWgxe+LCffAjay5Bbwf///TirQyhOYoWZLDjk8iWPRyf8bpvv9QBMs7lwXb/fQR8OFJN/LJ7C5qyVFpgju7a/4CBck1G9JOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmckDy/2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmckDy/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF56C4CEE1;
	Mon, 27 Jan 2025 00:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737938089;
	bh=KMdR3zEkNFzgtlBkobZBQzYlqXu9ohhKXNa9kVW7YcQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=CmckDy/2ZGehnxRFQUsIbGreQYHLuydlammQJ7m/k6SA9n4MaZCbCGdL3sgtDjRpF
	 MV7u5x90LMUZliygJpsNUtxHYiRsX3hnJquQv+RNTt2eRPPQ7FBq6fq4muR9UqNFoL
	 8kUChY2dtcR18E4351dNUGzz1G0S9lAxPOIsXG7elHh4DBumRRQQPM+keBEmDzUvaU
	 hEoU0+RU7c8e/jfvR45caLhX5LBG5weKzchuL2BMdBAD1VnYQsEgPDBO7KX+riogyc
	 4laH9fTKj418+vMNiT5oUdjRXxO9SKt/m4q/KVh5OCsp5F2+R11lJe9G1ZUhZW7Zvy
	 6FMXahGANUFqw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADBD380AA79;
	Mon, 27 Jan 2025 00:35:15 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.14-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <4f980400-1947-40ac-a062-fbfb4919546c@suse.com>
References: <4f980400-1947-40ac-a062-fbfb4919546c@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <4f980400-1947-40ac-a062-fbfb4919546c@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.14-rc1
X-PR-Tracked-Commit-Id: f3b93547b91ad849b58eb5ab2dd070950ad7beb3
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 41bfad507c04c3d0cced1277243aed6733616184
Message-Id: <173793811463.2914332.13119786845977940350.pr-tracker-bot@kernel.org>
Date: Mon, 27 Jan 2025 00:35:14 +0000
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Thorsten Leemhuis <linux@leemhuis.info>, Christophe Leroy <christophe.leroy@csgroup.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 26 Jan 2025 15:05:47 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.14-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/41bfad507c04c3d0cced1277243aed6733616184

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
