Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889B039CD03;
	Fri, 21 Aug 2026 20:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787344025; cv=none; b=B5+AEc3jbhTAK3LG8A6UHDb7XvCumILux35UwBxW0X0f7w77VueDDNl9nmvHfL2D0+q9BlAMv3beeOoVsTNi6bVEoQntwt4Jl/yd6EJUhz5+9453qDzq1EUQhtZAv7Y32UfxyKjTFVdhr+JZ0WP9B60x3hpntrTPoK0N9Ghd0zc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787344025; c=relaxed/simple;
	bh=X10vfU+GteWGkfJoQxwqe3al3CY8ff6bcK/CG4lFSxs=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=VQOz5ufPMwii4jHoPrG50af4C+oH4gJiAsQI4g4YuFSX0oY7RPcEgVPOiuIxvSVbwCTQCjkf/6u6ij6nNJIbhEeiR/dBu8Vd5Wo4b5t6ZGYu7TmOJwfhytZxDnfjGFJmp0jWnOXLFEev6hrE4482PX8BwpDGOVhoSKfg+kvvATs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P8FWZHQ1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P8FWZHQ1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C40A1F000E9;
	Fri, 21 Aug 2026 20:27:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787344024;
	bh=kY3osgfgGhbQ5/oMonK6g7KaNaOEh26Pd8TGNm0/QsU=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc;
	b=P8FWZHQ1qVdMsaitozVjbWs4jzact2ps6IX72yoHkoWc8JJ1qV1ODV+ojoslhaf7Y
	 DtEWfm+cYXfRH7y0dbDBdngH32vFC1yNxthcX7Wl5tKNuXT3YSs0q/q7X14vrOFZdx
	 qsZVTHNIf+o7f49kH0aj3sJk1KQlCi1EdMP/dS2WdVmT3iYP7k8KJEyLbUikq59bEk
	 cJmlaitIRFkpCIFWWUN5U4rB7GMqWjU7WNUUuAplzeNiOHlHC/9XgQ34KwZv4I1iF8
	 Qi2RFDU1VCjOFIoBdEpXvWwGw6bLzys1ba5xNuv0bqIrlj8A70eSrNGrV5fxDZRbnK
	 tH19mAcyPZyQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19838380CEC4;
	Fri, 21 Aug 2026 20:26:15 +0000 (UTC)
Subject: Re: [GIT PULL] Modules changes for v7.3-rc1
From: pr-tracker-bot@kernel.org
In-Reply-To: <a0068317-feb6-4152-beff-8a120cee2d51@suse.com>
References: <a0068317-feb6-4152-beff-8a120cee2d51@suse.com>
X-PR-Tracked-List-Id: <linux-modules.vger.kernel.org>
X-PR-Tracked-Message-Id: <a0068317-feb6-4152-beff-8a120cee2d51@suse.com>
X-PR-Tracked-Remote: git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-7.3-rc1
X-PR-Tracked-Commit-Id: 3dfaae04243cde460d82dfc2a7dd0bb6664d20ae
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 2f0f6b0773be0a1ec475097ae54848eea42adc7d
Message-Id: <178734397365.1471056.16769371929033471103.pr-tracker-bot@kernel.org>
Date: Fri, 21 Aug 2026 20:26:13 +0000
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Sami Tolvanen <samitolvanen@google.com>, Luis Chamberlain <mcgrof@kernel.org>, Daniel Gomez <da.gomez@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, Andreas Hindborg <a.hindborg@kernel.org>, Jiacheng Yu <yujiacheng3@huawei.com>, Naveen Kumar Chaudhary <naveen.osdev@gmail.com>, Stanislaw Gruszka <stf_xl@wp.pl>, =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>, Wenzhao Liao <wenzhaoliao@ruc.edu.cn>, Zenghui Yu <zenghui.yu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 21 Aug 2026 11:31:04 +0200:

> git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git/ tags/modules-7.3-rc1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/2f0f6b0773be0a1ec475097ae54848eea42adc7d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
