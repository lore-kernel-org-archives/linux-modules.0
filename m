Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4404A14D433;
	Tue, 24 Dec 2024 17:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735061391; cv=none; b=OfCOZQEqaNt8XddaNWmRxnIqs3IeVhFBPGXN8wGeUEmz607WBP5f+gyuQuVYTCMdmZxO9gkKbsHoWFeE061H0sVnU0U2br0a0iNVipEOVoYIoTDEewIw5CXETBcgf36usDY2vd++Fh8RZk98QEZrl2qpDQ5G2vvRdsmrQWUeW8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735061391; c=relaxed/simple;
	bh=phhf35B31kK98Vgz6hVplqQPi5UpGvFRCxrr6RUKcI4=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=eZkDdd/9sqf4Lq2RIielN2MGJBrvOaj9MWPzDOvwwR2wF2ANBlrtwBqE1we7rc1nx0ESDZasuZ0qasQbkWkHnbyGhFGtjw/l2xEOsZWonv/yjpIG/jK+NhcSO6FUtXoCRsSk2P12plyCFbrC6Jb3PlBDRvmU2Wc/sla1/PwX0Pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p5U/ANzS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p5U/ANzS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177F9C4CED0;
	Tue, 24 Dec 2024 17:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735061391;
	bh=phhf35B31kK98Vgz6hVplqQPi5UpGvFRCxrr6RUKcI4=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=p5U/ANzS1MzTfimg4WINeFvWKYKGQF3AdPa++dC8FXgBhcm5wNXo/DgL6b2TnMx+R
	 s2cdU6XDs8EAYsbnB8pkdRMJ4/SAZKKx+1gz1KKPPLQmMchanORCjuwbdvn4Y2/YzX
	 GRM5ofrTrK3nDs0GwI1OTr7LZaa0V/Zd0zV1b6Q/2dG6QTrHv/CVGBiJR52OFLtleE
	 HqWBruOv9RD0Sl03NVARtKbv4dMuLW105ActHKUFLXfDXkc8mGy4WHnrSniGtiO8OI
	 cX9+9tXomLKBm3wu//tZDSXjf4S8rN2Bn9jjY9bXz+ZBS6v83PPr2IWvQOF8yNtZV6
	 b1z+lXl8O9xFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EDFB5380A955;
	Tue, 24 Dec 2024 17:30:10 +0000 (UTC)
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
Message-Id: <173506140971.4160784.15529893249767146994.pr-tracker-bot@kernel.org>
Date: Tue, 24 Dec 2024 17:30:09 +0000
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
