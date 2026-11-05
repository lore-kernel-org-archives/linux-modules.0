Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793909916;
	b=xgdK5r8iS/4uop/PovWyRxR9kJGRrGADAY9cUowoKeuJmX1fVWFWvpEH9cuKWNzAvRz7
	 DTdoEumB+9T777NBrfymNw9rPYLIbOIGEYfxQhzOlxxlIf4dVmHTQxiX3ZUTDkYxm5ddD
	 EPfRTfALZ8LWVHZ8AxUuu35IHCFH4s6fbsEZsGDa5vBVkQAdYV/FjuiZCTU3fMqmctDvZ
	 a/m4D5k7XMh+iG042Igq5EDUMACdTiqUaJm83bJ584+30a5TRQ13ASb4/gIsYTk4W4vkH
	 RK/Jpdh0m225rtTkiX4yqoHNvP+o/qOA15U7Wh1fpe8W37qrt6d19nDX5DlcL7caXJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793909916;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=06kR7PQNbBp6coXeFFPLUhePXwp7UQV1w1MT8RSeXeY=;
	b=R1qrlUi1DzH/u2L/eTF8yH4ST47XNyoAWGjvqjnt2NokxmItHwCnGJS6nJu5qQlctdI+
	 2F8CoZg5nHTwrDllxh438brxnSAMjFjRPMnRLw23k+FtCA/WdPSdzdb7GDbOc8sHLLOE6
	 wvm1vhtGGyuOH8/8RFW9LTJBECyS1MoOUayFDjezzBAP5N/6WCXeaWngTH7VDn0DngWUr
	 37tOGgtClKxefI/zgiDTTLxwTjZwwzQw382fu/HWFPJmclL9nLvN8ewHsv2z+qxfPpvEA
	 fps9I4jzkNWvWetXpfiSHCVdLvPkuxNBpAsnS/jlI6/OQdjFLVu0FqToTcPkQDFZrYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APH9jPHw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2882A606D80B;
	Thu,  5 Nov 2026 20:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=APH9jPHw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643D71F008A4;
	Thu,  5 Nov 2026 20:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793909915;
	bh=06kR7PQNbBp6coXeFFPLUhePXwp7UQV1w1MT8RSeXeY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=APH9jPHwOsulgldpxBa7Nl/ATXd5K2Q3sdWcvdqjcriz5W4qbecyQDjlMzGkHM4mj
	 c+D4SxMydSXRDEUVjRxdNRnpKiJERxEF+2DZyyeH7ltB24NfdKp56OJJXKyhUnrfF6
	 1xyCo0dePTLqTLZi1yfXAQY50Thrh17oKpaGkvRhUL440XFG8wcQyWJ/Q6kBYnamVm
	 cUcVUgIn6Vu02POCglozyfnGb1hfIzc1RFNx8S+h4gv1NpnUUZ+rle2Kj3O0EVe9hq
	 SPsA3EEeCjs8qrdAiAeoILEwM9OSmwzV1a37PjuJsgq1dYFkT05OlruL7iXJ2yR2a4
	 Fvhd4SB1IiaAg==
From: Sasha Levin <sashal@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-kbuild@vger.kernel.org,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH v10 4/4] kallsyms: add KUnit tests for lineinfo feature
Date: Thu,  5 Nov 2026 15:18:34 -0500
Message-ID: <20261105201834.3238924-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <sashiko-outbox-195133@kernel.org>
References: <20261102111455.919102-1-sashal@kernel.org> <20261102111455.919102-5-sashal@kernel.org> <sashiko-outbox-195133@kernel.org>
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Post: <mailto:linux-modules@vger.kernel.org>
List-Help: <mailto:linux-modules+help@vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-modules+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, Nov 03, 2026 at 11:15:28AM +0000, sashiko-bot@kernel.org wrote:
[...]
>Can GCC's identical-code folding (IPA-ICF) merge lineinfo_cross_file_caller()
>into lineinfo_target_with_arg() and cause test_cross_file_inline() to fail?

No. GCC 14, 15 and 16 keep them separate on x86_64, and so does GCC 15
on arm64. The test did fail on arm64, but because all of the caller's
rows land on a single instruction.

--
Thanks,
Sasha
