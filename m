Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D924338B7AD;
	Tue, 10 Feb 2026 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770747025; cv=none; b=YMTXCiADSscp4P3/Ftl4/xSgtn3/pnf+WJdj1vry8pd3LUxU4SdsxxsK5XyFqlsj8+ieNO1MuPhD3k/psxkT2YaZ0pdS9Nt/J8N6WrEIvNQfAeBwwgv5kxELdmpJzzeNwu5xoUyB/eWL1mJrhh/Yq6YV+WXfATW7SMTBTMCsH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770747025; c=relaxed/simple;
	bh=UgqXbOPRRJrnwy+z2wD9OKlEopx0GYmFJo8fD839QBU=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=pa3894S3gLBmtN/6Z4ViAdG1lPOHZ3Q3Zz7m/cNdTVr93H2y7D444LMFiDqK0ZkTk3LeM9GnhLUrhqW+0SXYp0i0Qrkaaoe8/iW2TUUi0b3ZNHBXpfzTONOrTmG+IgA0XeP1UUo2Ay1164NLd1WyNNVeQcCNDj3OEjjsrTH6ZZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sfR8lzmJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sfR8lzmJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 783BBC116C6;
	Tue, 10 Feb 2026 18:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770747024;
	bh=UgqXbOPRRJrnwy+z2wD9OKlEopx0GYmFJo8fD839QBU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=sfR8lzmJTWmdm5WHyvAzgJcukorl51MnJydztNajv7AsL1V8Gz3NR8AQtqiU6RG8z
	 cMHaPypurl4BtP1avPG+k2W2ijJgjfvv+oNOSHeUpemGmi9T31gMu67CoOBAe12+ed
	 D/m0Zhs1iZskyLfavY2KfvUCJdANLjBFSAqxNScUxR7ia/ZMNPUv1RxclDChzl9//J
	 DBVolKTFkr2eL7SuYMjttcUDiaGLlLeeI3AQoJUOGOtLsYpc+gdVFRAgusyvrsl8Za
	 8VPfeJaxaUoJsrVWjDDd7gAuzFoySynrRq4C8W01mpSAxt0sfBGutEMBPudV2auBg8
	 f1G/DXsUBi1bA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 0B0CF39D6574;
	Tue, 10 Feb 2026 18:10:21 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v7.0-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <20260209155527.1385229-2-samitolvanen@google.com>
References: <20260209155527.1385229-2-samitolvanen@google.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20260209155527.1385229-2-samitolvanen@google.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-7.0-rc1
X-PR-Tracked-Commit-Id: b68758e6f4307179247126b7641fa7ba7109c820
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: a7423e6ea2f8f6f453de79213c26f7a36c86d9a2
Message-Id: <177074702029.3619225.16746508533184682505.pr-tracker-bot@kernel.org>
Date: Tue, 10 Feb 2026 18:10:20 +0000
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
