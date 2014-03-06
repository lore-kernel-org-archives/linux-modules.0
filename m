Return-Path: <linux-modules-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59501 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751548AbaCFRSS (ORCPT <rfc822;linux-modules@vger.kernel.org>);
	Thu, 6 Mar 2014 12:18:18 -0500
Message-ID: <5318ADD8.2030108@suse.cz>
Date: Thu, 06 Mar 2014 18:18:16 +0100
From: Michal Marek <mmarek@suse.cz>
MIME-Version: 1.0
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	linux-modules@vger.kernel.org
Subject: Re: [PATCH 4/8] testsuite: add test for '.' correctly parsed in param's
 value
References: <1394114809-2737-1-git-send-email-lucas.demarchi@intel.com> <1394114809-2737-4-git-send-email-lucas.demarchi@intel.com>
In-Reply-To: <1394114809-2737-4-git-send-email-lucas.demarchi@intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-modules-owner@vger.kernel.org
List-ID: <linux-modules.vger.kernel.org>

On 2014-03-06 15:06, Lucas De Marchi wrote:
> In kcmdline it's possible to have a dot in the param's value. The
> support for this was added in 66f3228 ("libkmod: Add support for '.' in
> module parameter on kcmdline") and is needed to correctly support some
> modules that depend on it.

The tests look OK. I tried to revert my fix and the test failed.


> This test was added in order to make sure the commit  aa87854
> ("libkmod-config: Only match dot before '=' in /proc/cmdline") didn't
> break it. Although that commit  message says it's allowing to match a
> dot before '=' it's actually enforcing the first part of the string to
> be always in the format "<module-name>.param". Dots after '=' are still
> correctly allowed.

Yeah, the wording was not really clear.

Thanks,
Michal

