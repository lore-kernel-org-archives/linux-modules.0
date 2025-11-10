Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C15266B67;
	Mon, 10 Nov 2025 16:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790515; cv=none; b=j6M3F1buZHGj7IoGmgTfDbz2tZ5+H07AoG5nuGfi4hy+uG7zPPMOe0OanpySqr2uLB8O5EXGOaESdzwtbc2/F6Jc6KvY/YCIh78Dtbd6Sq0zKmLyHpXV/xiVphg8lwLc1wkh1KFaxwfavHomdcZTLwKrAJc3ZQSJ20Bv/BziRcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790515; c=relaxed/simple;
	bh=H3NzdekXo1UQ4hcp/ZKn7Ol5GFdG7uTg3XxzFPfkbRo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bY04llu3kjth1N0bCu+2xxLu93+4nMNM8MB53WVB1f1TiMYBNVlqBDp+FUlotddQDBXLOe7Z3jNpGUPun3wIIwSILFJZ4UAN+B2kXYnFLX25GzZQqtrSirNK0E96FFxusJUjFxT4PC06Tnr+mQHXe9M/bSWqQw4veTInx+ZfV7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYkm0xuV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYkm0xuV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F3CC4AF09;
	Mon, 10 Nov 2025 16:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762790515;
	bh=H3NzdekXo1UQ4hcp/ZKn7Ol5GFdG7uTg3XxzFPfkbRo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYkm0xuVNWAlGseBVO9lGJaJ02l/6r0SQAffp1TGc2D3yBWtDSGPzi8OeJIeCaRtM
	 S+gJi9KlHnOyxQo4xHV2gX+5SklCzTu9vfJ9Mvs7uJZ8pJm3ak1gpSNyfR0iG/3Wxz
	 bAG921OEMcsk4Xn4umAJZh5mXROIX295g6hl2RLJe0k8OFKptDUTEmylzt6lPDDw4p
	 TldzfWLbUkXlctCY5eDxKv2UkKFPcouC2qx4ppuB9DwwFjx9BtZZlLyw7Z89Bwv9i6
	 F5Fo74rsN2dOGhGzsRT986mo6T1Pis9aLwJRNIhmMYbRWLHA/gzlHZgBjfZIR/TeYG
	 lC8l7f1moRETQ==
From: Daniel Gomez <da.gomez@kernel.org>
To: mcgrof@kernel.org,
	petr.pavlu@suse.com,
	da.gomez@kernel.org,
	samitolvanen@google.com,
	Aaron Tomlin <atomlin@atomlin.com>
Cc: Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add myself as reviewer for module support
Date: Mon, 10 Nov 2025 17:01:29 +0100
Message-ID: <176279045446.4004696.4134618363007891892.b4-ty@samsung.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018180210.347619-1-atomlin@atomlin.com>
References: <20251018180210.347619-1-atomlin@atomlin.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Daniel Gomez <da.gomez@samsung.com>


On Sat, 18 Oct 2025 14:02:10 -0400, Aaron Tomlin wrote:
> Voluntering as a reviewer for Module support.
> 
> 

Applied, thanks!

[1/1] MAINTAINERS: Add myself as reviewer for module support
      commit: 1ddac5cd7f278345b2e8298c930e4bffe0911a45

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>
