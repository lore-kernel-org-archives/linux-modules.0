Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16474125B2;
	Mon, 30 Jun 2025 13:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751291847; cv=none; b=sQ6Kzd3Crbe7vrHrBeiEMwH/yNOS0Q7lXSuc/bjJXe2V/CAKcxIlNipqqkl/BXZuwLwtzDPeq/ds7ncxtpZjdG5rK6g9PRmlAbNLei5x5Kd+FpP1ReQsJ4nGVzPqoMncxZTD//jn7V2KjCCMrsmn7YmyluC09SC7R5+esTDmLCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751291847; c=relaxed/simple;
	bh=guCpz+F7x+94rdtkC0HBB2q7MaNtv0m53Zyv72XbB48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iv3sKLRYsemn1YcyNah8eU40b0lCR2/+W5allsVdsXDWegdcVQ0s1GWUGpcpu3AABiIDhXh+xDgGUdBIiP1Z+SJb29XvX5RX7pv7Pga2V5FWjN/uiTAbdRXAdrtbOEGjW0myz164IrIW4ipAzROMzwhhkG2wVciMd5HC4gdZOkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KaybrawS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaybrawS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DCBC4CEE3;
	Mon, 30 Jun 2025 13:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751291846;
	bh=guCpz+F7x+94rdtkC0HBB2q7MaNtv0m53Zyv72XbB48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KaybrawSGDrNmyiRPNOTLAXdNWTwfQ3zr7eAxqhJygKDcblj3JLkjSqcKAo1K37i5
	 UWiGno+qPz/p40sMZGQDDBfUOPCo7hKtJSBJo9H8qqzTvmaXTt0QYlw/EFx9f6ONNn
	 qbEH2j+uZfdGooLswk6YF54lPdDy1vdL91QEkDinT30VV5B+yrpouxrvoHkWcZG5Up
	 pGroemuX2Siu8XY+u3SYCTnecaa+q+pMeitHa5/4IK9iVt1D0VHTR4tuY+WrK+3jIP
	 m+64Hw0WAkmQ9N3wcYSpYNGBirQRvKLQyyuuE7KC1FejihWtbOPmR8ZkW4e1ibQkoJ
	 ftIkYHdx4HEVg==
From: Daniel Gomez <da.gomez@kernel.org>
To: Luis Chamberlain <mcgrof@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Petr Pavlu <petr.pavlu@suse.com>
Cc: Daniel Gomez <da.gomez@samsung.com>,
	linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] module: Fix memory deallocation on error path in move_module()
Date: Mon, 30 Jun 2025 15:57:12 +0200
Message-ID: <175129179614.19111.13897690853396282394.b4-ty@samsung.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250618122730.51324-1-petr.pavlu@suse.com>
References: <20250618122730.51324-1-petr.pavlu@suse.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Daniel Gomez <da.gomez@samsung.com>


On Wed, 18 Jun 2025 14:26:25 +0200, Petr Pavlu wrote:
> The first patch is an actual fix. The second patch is a minor related
> cleanup.
> 
> Changes since v1 [1]:
> - Initialize t to MOD_MEM_NUM_TYPES in move_module(), instead of assigning
>   the value later.
> - Merge the definitions of the variables i and ret in move_module().
> 
> [...]

Applied, thanks!

[1/2] module: Fix memory deallocation on error path in move_module()
      commit: caca01f251ac37807ff10380d5dafb9576cdfef0
[2/2] module: Avoid unnecessary return value initialization in move_module()
      commit: f4e47f3ac79849846189058491ff885491223ab8

Best regards,
-- 
Daniel Gomez <da.gomez@samsung.com>
