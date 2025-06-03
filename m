Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11ECB33E1;
	Tue,  3 Jun 2025 00:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748911471; cv=none; b=tgcz5umGTF316A8+tE3RTot2rJdZXDada818CznEOX7IloKSG8acoc51qEeIppEYcMGa0XuaIpkvu2uZNVPzb2bVTcqWJL9nu1GNv+xO8vSC1kmDrNIIAW2hsOAAy305pCSEkSYPr67/fJsD/8LOioSAN+gbUVQA7k4gT0OaEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748911471; c=relaxed/simple;
	bh=GZlx8iTnrJuj41NTaVD5xc2P1HxNEVVh4V46DfqGG3o=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=bOuWLZELs17goNzhRlpaG0FRNeHVZ0rHFN+2E0sJ5LJCRsC/KtPDDdG2t35QhS79a4I8HK8Of9ecYKmx4JPLk4r0EM+P7Czrf2DN0EPG3PwR9QtnEWrpFrvcH6SFS2CZdqN5E1adZWRlw/U4CDvaJ3D4qePsUH/dt+isL1GSvDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M6yReL/t; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M6yReL/t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF29AC4CEEB;
	Tue,  3 Jun 2025 00:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748911470;
	bh=GZlx8iTnrJuj41NTaVD5xc2P1HxNEVVh4V46DfqGG3o=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=M6yReL/tSTvpVs/cdnvyzPnOk2rIzOleBBCDjr3EsNLgcb0Hh1ZUtQTUPU4dIZh3e
	 zW/99j7U0ovpRJ+aeffP8jNfSCeey5VxOXLf7He1EPrjMztLrfQDq2VN7ReGC5No+8
	 A24Mo7II2ZEwnc7NNRWKObN8tfImF5lrVkrLAYBB0NwcjWz8svceJZVEOsI4He/ZZH
	 7hjLDD9wZ/gJA3TQdc/GTqo/CYh858IMpjRcxtSQqrKPcG2V6m0JbKX3aDGSkXbf2m
	 MA/jRl9vPqmtQNg0bqheAsDExBVtjH6m2AwzbKGa6BNGZwGMtAPjXfBOcQzCPuUwG+
	 sUzRC8xtusEpQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE090380AAD0;
	Tue,  3 Jun 2025 00:45:04 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v6.16-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <458901be-1da8-4987-9c72-5aa3da6db15e@suse.com>
References: <458901be-1da8-4987-9c72-5aa3da6db15e@suse.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <458901be-1da8-4987-9c72-5aa3da6db15e@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.16-rc1
X-PR-Tracked-Commit-Id: a0b018a495a3f68693e45ab570fae8191d907d86
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c8be54240893dbf89c294cb6a9e338fdc2f73ead
Message-Id: <174891150313.965188.592284763854275037.pr-tracker-bot@kernel.org>
Date: Tue, 03 Jun 2025 00:45:03 +0000
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Luis Chamberlain <mcgrof@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, Valentin Schneider <vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Mon, 2 Jun 2025 16:34:45 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-6.16-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c8be54240893dbf89c294cb6a9e338fdc2f73ead

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
