Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD51A32D0CC;
	Tue, 10 Feb 2026 18:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747025; cv=none; b=GBXhJmKKVtHkllBx0PGN7hFrBeXQ9HY8m3QGW3FWrWShGBj591qVGnFoSVHGXcJZUPjaF0VeT6LVc/VC3JS8RzS0WThS0gN3puHlawFpu+kGA4s+bdU2DY/VGOloSYrauqQPdaxUNkOMdvGpY8Rse8aqwpWcb1M3fplUiG5kHzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747025; c=relaxed/simple;
	bh=UgqXbOPRRJrnwy+z2wD9OKlEopx0GYmFJo8fD839QBU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=SDO4b9/UzgvHiO3LSnqWHatpf417XaXmvGVPBfMO0ZWUMazSEqk0WibUv5FCkTujI82adBMYT752JaeWM6CQ2x0s6mK00LuDMJMOOZxbdzFdm5qfwRqDIxCt6fmR1Hk0DYsrz22a9mMM3mXoNGstcbusvG+WpBC1Jr100DfGtaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zqc4SSEJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zqc4SSEJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C38C19421;
	Tue, 10 Feb 2026 18:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770747025;
	bh=UgqXbOPRRJrnwy+z2wD9OKlEopx0GYmFJo8fD839QBU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=Zqc4SSEJ8wBOnCRMR1/ZUmyOx/JHI/iJ/t/pMpC73qM3M2EfhjaaSTGG3IPHv5TJ6
	 J/1TxFpIUSKkuJG+NNbfhWh3JX2T2nLaJrw7UwXZCKpfTXSAgbW+sB61ATcUWLybs2
	 65N5n/zplWDRcpPy/km7wF965reVxl1WgEXvLaJdHN6K8aPFmZ/wiBVQhWhgdFGfFC
	 525tkcjTDGGn83jVRvW4WN9zZgpgjJWAqHnYKW2ApQqlqaIDJDNt8QVvbeQBcr2xuD
	 YIEVUo8S5qk2YqBAQDBd3l03sVU2xEskW6N2SCLrBZyDf4MYst7jf8MO3DT/zIopE6
	 +T0V5mvA1iQIA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 4831539D6574;
	Tue, 10 Feb 2026 18:10:22 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260209155527.1385229-2-samitolvanen@google.com>
References: <20260209155527.1385229-2-samitolvanen@google.com>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260209155527.1385229-2-samitolvanen@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.0-rc1
X-PR-Tracked-Commit-Id: b68758e6f4307179247126b7641fa7ba7109c820
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7423e6ea2f8f6f453de79213c26f7a36c86d9a2
Message-Id: <177074702106.3621857.179619867900066207.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 18:10:21 +0000
To: Sami Tolvanen <samitolvanen@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, Coiby Xu <coxu@redhat.com>, Daniel Gomez <da.gomez@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>, Marco Crivellari <marco.crivellari@suse.com>, Petr Pavlu <petr.pavlu@suse.com>, Randy Dunlap <rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Mon,  9 Feb 2026 15:55:26 +0000:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.0-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/a7423e6ea2f8f6f453de79213c26f7a36c86d9a2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
