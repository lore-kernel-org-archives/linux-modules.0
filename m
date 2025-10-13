Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B6219E97F;
	Mon, 13 Oct 2025 16:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760372828; cv=none; b=Bg8dOvJc+Yx6BHViQJyDjT3KRN8uHhDrg9RkEzioBCbd6B9zla4znjUk4/THLrEkIoKbFbgDC68DQ9DZPXIp/u3EMeAAdnFmkbdnB2WcheM+53ovqC+X42dJeEiZFMAMM5WtLKbczjoeEvB7MFOJR1hDOn+Sb0Y29Tk2hN+iOKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760372828; c=relaxed/simple;
	bh=suCC78EMKqPxfBXcTYCLFKc0L3dpAc7sp5mhcdIFfK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sPiWX59YSr1nlNGuzlm54iuica4kUTNO48MINe3S5H8WrTKz3o4CrtQjz28Kt+1h4h1gJJTltZefpn1qJmLXpnmX1gul9gapypBHTEvfyboYew1o8VaSMxXQPVKkQ1aBOlzKtTErdqhvQvOlcJ7M05e0SfFz5rTvzt43Pnv6618=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YqiI/xG6; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YqiI/xG6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760372827; x=1791908827;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=suCC78EMKqPxfBXcTYCLFKc0L3dpAc7sp5mhcdIFfK4=;
  b=YqiI/xG60KNAxAEBgATvajBgriIlUbWlK0rHMvPMZFVKHRrt+2xPmvFA
   JoR7KMW3QHpIWjhJOwqzK5mI6lyuV9OUr2vSttnjs5syBqbhpKfOolC8h
   BfIr6n91ukrR1LACCxVDqnBYevRZc59ngISxjcLeEZN2ncLMyUk5+1bzt
   H1UuNmo3vRiiWdJsTy/G5bH1DzpN8n5v4BXXdDp7pAxDYm4U0GYQejX8y
   6pHf2HsUCmJ+LkzCETI5uBO3/SaMHY0batLCi18Kc2Pd8XoHBBjrMCKo7
   VjN8O5aZFkKOqseyU2vRhlo17kjvoJu65RRdQjEgifQht7c+sou3cvlpM
   w==;
X-CSE-ConnectionGUID: 0i7AXtmVQ8mIG2RMwyGEbg==
X-CSE-MsgGUID: rJe9e6dTRyGSxWypRHd2iA==
X-IronPort-AV: E=McAfee;i="6800,10657,11581"; a="62409331"
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="62409331"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:26:58 -0700
X-CSE-ConnectionGUID: WzdLiMwXStqGBQroMZpjaQ==
X-CSE-MsgGUID: KAMvVxadTfelWZEK4MU8eQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,225,1754982000"; 
   d="scan'208";a="205331718"
Received: from lucas-s2600cw.jf.intel.com ([10.54.55.69])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2025 09:26:58 -0700
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: linux-modules@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@intel.com>,
	Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH 0/2] module: Tweak return and warning
Date: Mon, 13 Oct 2025 09:26:22 -0700
Message-ID: <20251013-module-warn-ret-v1-0-ab65b41af01f@intel.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Change-ID: 20251013-module-warn-ret-59f085298055
X-Mailer: b4 0.15-dev-bd47d
Content-Transfer-Encoding: 8bit

Do not let userspace tools and end users confused on the return code and
log messages.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
Lucas De Marchi (2):
      module: Override -EEXISTS module return
      module: Simplify warning on positive returns from module_init()

 kernel/module/main.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

base-commit: e5f0a698b34ed76002dc5cff3804a61c80233a7a
change-id: 20251013-module-warn-ret-59f085298055

Lucas De Marchi

