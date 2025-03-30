Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28695EEAA;
	Sun, 30 Mar 2025 23:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743375823; cv=none; b=UChSulXpPV3nJlMBSoY+++8N66wOqHIk5Z4/OB+W44enmsbQ4vAEi+VeDJRkJxviaCP059YXEmM3v3hTG5Q0Fs/pq8RxPF4Ey3JWPkjoul7iMXUxWk0LNa+Bia2nLXivE+Q3I0tNqPjxseOY0Ihg73lGV5Yb6Eh2cAbKZIv87ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743375823; c=relaxed/simple;
	bh=7sPXz0hT95wgkMUxsoctqI72U6vwaH2jSwBBZac4QAs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=q382nkfdmsCzFo1EvOdxhFdfvIJYQWTf4eceBRFwgAQQQlCIHajWhYm+4seq0jClpzX5F7stMPhWxY5DtaV8sNZ8rv4Y8WEMSFmAgF60tSihWewYiipLA2eyFTloz6n2hkV3Mq0+WkZAPXA3HfjxbE/KuDjw5TRQ1DvaeWQldbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcJwJ5JL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcJwJ5JL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F5ECC4CEDD;
	Sun, 30 Mar 2025 23:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743375823;
	bh=7sPXz0hT95wgkMUxsoctqI72U6vwaH2jSwBBZac4QAs=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=bcJwJ5JLliE5JUrWR8NBlxp4ay63rX1O+W5HGB/MUICF94RCPgcoFh3/P0CgmnhOU
	 jFioJBH+NrO1Ijz2/8Zjf+XcLC++WaoNvaJquwZ24jbJkgnt9bWcegraXOEKmQI2Xp
	 7LSdyPYXa7FCIyU+iYxfZLYvWZ1iONfacPge9G6GmRoMeTDYHMMdP1KVjlqsIZ9PZg
	 TPW7K82XGpRvCRG6PBfcnZC1BNfBtcCuSzHH42xhFGbIiKDtlPbsdC9sN86taP8/TD
	 /ZrJSDLAyxPpoXMr3kHLo8vhA4psXBCww3cIsbueQbjIpQXmB8W5i5Skb11t5HBnVP
	 4rqBEFGYaO1NQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34550380AA7A;
	Sun, 30 Mar 2025 23:04:19 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.15-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <8aaaca23-ed2c-45d8-b9d2-7c8bbd4a27e5@suse.com>
References: <8aaaca23-ed2c-45d8-b9d2-7c8bbd4a27e5@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <8aaaca23-ed2c-45d8-b9d2-7c8bbd4a27e5@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.15-rc1
X-PR-Tracked-Commit-Id: 897c0b4e27135132dc5b348c1a3773d059668489
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 01d5b167dc230cf3b6eb9dd7205f6a705026d1ce
Message-Id: <174337585768.3614380.14040896783307790609.pr-tracker-bot@kernel.org>
Date: Sun, 30 Mar 2025 23:04:17 +0000
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Joel Granados <joel.granados@kernel.org>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thorsten Blum <thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 28 Mar 2025 16:53:26 +0100:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.15-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/01d5b167dc230cf3b6eb9dd7205f6a705026d1ce

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
