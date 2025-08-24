Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5892320A5DD;
	Sun, 24 Aug 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756045147; cv=none; b=pTl9+r58L/4S9990+4euZosqr1DY/Tm0LBkNPuA4THEh7+oIi6CsYAL45WvETCTRuf82eRoE6IElA9v4I1wQmognym1p26lCzSP87WXe1GXL6BDqjVQskmIwVADlqrRzKxjEmnlPN2qwnIGOitQ3//0KXFDOxDwS2POGa1DmCOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756045147; c=relaxed/simple;
	bh=PkBAKTxO/GbQ4pPwudHevH0p3Wyb2ak0OFTq6XZCBYg=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=Tp89sgD+wRZVuGEJaxcMdt1GsBCSi2lngyYBiNF5ZGvBILtUiXmDpBFw0N5IvcgrLh98LC2p/xLf4XEAbjBun46TNmxH7mZwS3yXdai7nVaRmG4ArSDZTWVGI7s2/N+1fKHkpqtQZfj4mFQaHAyoXWSTJIpnDT2cb/Md/6gq/MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvwUbrlA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvwUbrlA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD7A9C4CEEB;
	Sun, 24 Aug 2025 14:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756045146;
	bh=PkBAKTxO/GbQ4pPwudHevH0p3Wyb2ak0OFTq6XZCBYg=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=EvwUbrlAN09bNrhrC1QV+cCKgmVFVt6TDzWSyGfHcO6c3Ld+U7YVRcEixSIa7P0tC
	 9A1N1UVPGx2Fgq5fGrlcndxQL0I2l7Q8KdHCbUPSwa6BxgRnAYs+muX1JsCA3Pi8XQ
	 UKrWrQkk/ZCLJgkLGhL2EGjcPT/TVKF3/7mrN75gONp4hgEKb++yoLYMuFpjRNaNWY
	 wupIqc2ybGpXjpEjMA+Dg6WA/0SJntIEuVdympRttr1xJqXmtivEJo3dyW88jqmjgq
	 KO3LTPAqDwmuHTHwQE4vJ9Dqh3qZG28VgOm5TEGgAXyjKSkfIG4wokcIe2za15wNl+
	 wsaPBPnWNNT5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EAB383BF69;
	Sun, 24 Aug 2025 14:19:16 +0000 (UTC)
Subject: Re: [GIT PULL] Modules fixes for v6.17-rc3
From: pr-tracker-bot@kernel.org
In-Reply-To: <20250824064922.41894-1-da.gomez@kernel.org>
References: <20250824064922.41894-1-da.gomez@kernel.org>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <20250824064922.41894-1-da.gomez@kernel.org>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-6.17-rc3.fixes
X-PR-Tracked-Commit-Id: 5eb4b9a4cdbb70d70377fe8fb2920b75910e5024
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 14f84cd318bed3fc64c6e4ee6b251f9b6a8e2a05
Message-Id: <175604515495.2399738.7893584771825606023.pr-tracker-bot@kernel.org>
Date: Sun, 24 Aug 2025 14:19:14 +0000
To: Daniel Gomez <da.gomez@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, Thorsten Blum <thorsten.blum@linux.dev>, Kees Cook <kees@kernel.org>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Sun, 24 Aug 2025 08:49:17 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git tags/modules-6.17-rc3.fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/14f84cd318bed3fc64c6e4ee6b251f9b6a8e2a05

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
