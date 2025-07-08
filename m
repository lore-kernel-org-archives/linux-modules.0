Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5F11C5F13;
	Tue,  8 Jul 2025 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752006582; cv=none; b=QursUASq4fVobPHX4wLjLH5MMMwmbP5DTHjBvjtTL2lttwd9i30ekyI8TLbr9KTwztFJZCxqPRyyeUNOjTh4SX7otIZ7w/adxqLbIra6/xEqVud7WkiCcOc4naw1atZq7y/1uoZDXugiEmDh95XNU+dXvVP+nRUUGC/JKEz/Zb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752006582; c=relaxed/simple;
	bh=gFtal+fQadVz1w0WUnUrow2qCoF8v5o4QyzuingHrf8=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=DGUVS6LpErs8of/8hzf+m9FeYrAPINhlNDrLc8aDzqP/toKq0TYat0TgChYm0eD7rMUVtCaJ7+XLDmroCbIvWU2IGU1QzuPHR1DzV6ihMlOmPp7p0MhuIdrMAUQ5tPrlANPvuSIIm23cpRnsRKpcjm3DjHpFvy40IByNf0EGlK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d38ro/13; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d38ro/13"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44640C4CEED;
	Tue,  8 Jul 2025 20:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752006582;
	bh=gFtal+fQadVz1w0WUnUrow2qCoF8v5o4QyzuingHrf8=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=d38ro/13ADjofAd5IpqBoxlBLzCBRKKgz+UPwdObIk3alUuGOegcejbsuYri5UIlF
	 r59J9R4gbtuak/PuH3V4ToXl1G+rprNr7IMpSUYaectuA/cj6pomnKyINuUBhOqF+D
	 pF8e+XD5WCqXZGGMHauqx+QPN2U286218GI+a2Pwdvk982pEa0wpeuKg0CCbqPqWpC
	 Z3gcxWq4/V2j6jdivu3aMn2T7vpO6jqZpOaB7PmJCzTbh8Skd/jYZiIKrCEXrTuc5y
	 rtCctWEVMIzXjXXEQW+46ViFo7zVWuq2COWSbWUY9AvwrFXoND6t9tKyr1Yg2DwP83
	 iD87iWNm2B1wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B84380DBEE;
	Tue,  8 Jul 2025 20:30:06 +0000 (UTC)
Subject: Re: Re: [GIT PULL] Modules fixes for v6.16-rc6
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAHk-=whHRv28HBL47x-L5okG+fZDJyX432uxG3AQqbqRAgkAYQ@mail.gmail.com>
References: <20250708193822.45168-1-da.gomez@kernel.org> <CAHk-=whHRv28HBL47x-L5okG+fZDJyX432uxG3AQqbqRAgkAYQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAHk-=whHRv28HBL47x-L5okG+fZDJyX432uxG3AQqbqRAgkAYQ@mail.gmail.com>
X-PR-Tracked-Remote: https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/ refs/heads/master
X-PR-Tracked-Commit-Id: 80e54e84911a923c40d7bee33a34c1b4be148d7a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 046cc01be6b9d139b49dfc396b7201c633ff1a26
Message-Id: <175200660462.4553.138160273996780762.pr-tracker-bot@kernel.org>
Date: Tue, 08 Jul 2025 20:30:04 +0000
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Daniel Gomez <da.gomez@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Tue, 8 Jul 2025 13:21:09 -0700:

> https://git.kernel.org/pub/scm/linux/kernel/git/mpe/linux-fullhistory.git/ refs/heads/master

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/046cc01be6b9d139b49dfc396b7201c633ff1a26

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
