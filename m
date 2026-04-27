Received: from jpms-ob01-os7.noc.sony.co.jp (jpms-ob01-os7.noc.sony.co.jp [211.125.139.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76EA31E82E;
	Mon, 27 Apr 2026 02:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.125.139.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777257735; cv=none; b=lBsmkXRZ02sj2attpP2kXAYtOldL1zg4OYLv046f3ohVe6gn/Uuy2VbAYvqJtvvM0vtbwQfjm0CfVvuHRipjsTEFRHakgN2TNFJwE/mnkaIalkB+XpBJzXfr56jbCOujsIzrFOd8vlY//V/7SW8ulDqqCb/uw8nfLQeMbIFYnoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777257735; c=relaxed/simple;
	bh=Bc6B30GXoro1QIrZ2ACQX8CrnIUIWdRhjjFxqv9HIMo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=adM6vHuvkuTIAo0yYKU96NJWJzX2LCKFN6qFwAwwHbMCnOGVAYtDnBjL5pzmIMJEfIWcofhIv2EhsqX1yy2EMDaoZmvrYBaBhayTLUxYaYofWzXZ7gjgOoUA0dky5p1qJodt9ZWz6SCaJJl8zucTNA3aD5RE9YB4pDMWW7dIAz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=fail smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=P8uFp8qW; arc=none smtp.client-ip=211.125.139.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=sony.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="P8uFp8qW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=sony.com; s=s1jp; t=1777257731; x=1808793731;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:in-reply-to:references:to:cc;
  bh=qhtscWonEKOFZrQW+3xWMuRK2rrdNHFur8IInUkqd5Q=;
  b=P8uFp8qWuXuMmPI/BzHN1pq9LPXroiDeGUH0AQdkifUlvFR6KsVAPiZH
   Zx0q6/rZDdxFYqoyllC0cg3uJZnmA8GOdutpTtM3pzcqfP2v5WitLoaZv
   CD0cknoLxkf8xplw7bU6PeLrmAjcNZ8qZ+C3tuVD9Zo8VYAcAW6Y8rQXb
   iqO68rSbJmfbnpnwhE1QwyKiSEhSl9aa+1byMoRxrQjz7VyVpLplbtLaG
   VeffIKt5+y+ql1KDc/QmnMmHPmysjU7a2CP9ukMnLqaDuSnrZ7SzdYVNw
   sRCQD54uu7dmougEGWlOswjSERzqtTJAPPfXfxXWNWvwqM8vHs6j5mtL7
   Q==;
X-CSE-ConnectionGUID: lQyQBs0gSJiAez883wMZsQ==
X-CSE-MsgGUID: CW4FryawRNaZbpR2qn8Fow==
Received: from unknown (HELO jpmta-ob02-os7.noc.sony.co.jp) ([IPv6:2001:cf8:acf:1104::7])
  by jpms-ob01-os7.noc.sony.co.jp with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2026 11:42:04 +0900
X-CSE-ConnectionGUID: +W+n/bPoRC+IUCG6r6jjxQ==
X-CSE-MsgGUID: +R75kAZwS56p+O/DwSqFEA==
X-IronPort-AV: E=Sophos;i="6.23,201,1770562800"; 
   d="scan'208";a="52275250"
Received: from unknown (HELO [127.0.1.1]) ([IPv6:2001:cf8:1:573:0:dddd:eb3e:119e])
  by jpmta-ob02-os7.noc.sony.co.jp with ESMTP; 27 Apr 2026 11:42:03 +0900
From: Shashank Balaji <shashank.mahadasyam@sony.com>
Subject: [PATCH v4 0/4] Enable sysfs module symlink for more built-in
 drivers
Date: Mon, 27 Apr 2026 11:41:20 +0900
Message-Id: <20260427-acpi_mod_name-v4-0-22b42240c9bf@sony.com>
Precedence: bulk
X-Mailing-List: linux-modules@vger.kernel.org
List-Id: <linux-modules.vger.kernel.org>
List-Subscribe: <mailto:linux-modules+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-modules+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANDM7mkC/3XNTQqDMBCG4atI1k0xP43aVe9RisRkpqagEWOlI
 t690W5E6PKDed6ZSYDeQSDXZCY9jC4438YhTwkxtW6fQJ2Nm/CUq1QyRbXpXNl4W7a6AYpKXnS
 mQIisItF0PaD7bL3747fDu3qBGdbIelG7MPh+2h6ObL371x4ZTSnT0hYKba5McQu+nc7GN2RNj
 3yHOTtiHjFkAgvBUqutOGCxx/yIRcSa5RIQC0SFO7wsyxcEjrLlNQEAAA==
X-Change-ID: 20260416-acpi_mod_name-f645a76e337b
In-Reply-To: <20260422-acpi_mod_name-v3-0-a184eff9ff6f@sony.com>
References: <20260422-acpi_mod_name-v3-0-a184eff9ff6f@sony.com>
To: Suzuki K Poulose <suzuki.poulose@arm.com>, 
 James Clark <james.clark@linaro.org>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, 
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
 Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
 Aaron Tomlin <atomlin@atomlin.com>, Mike Leach <mike.leach@arm.com>, 
 Leo Yan <leo.yan@arm.com>, Mike Leach <mike.leach@arm.com>
Cc: Rahul Bukte <rahul.bukte@sony.com>, 
 Shashank Balaji <shashank.mahadasyam@sony.com>, 
 linux-kernel@vger.kernel.org, coresight@lists.linaro.org, 
 linux-arm-kernel@lists.infradead.org, driver-core@lists.linux.dev, 
 rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
 Daniel Palmer <daniel.palmer@sony.com>, Tim Bird <tim.bird@sony.com>, 
 linux-modules@vger.kernel.org
X-Mailer: b4 0.16-dev-3bfbc
X-Developer-Signature: v=1; a=openpgp-sha256; l=5490;
 i=shashank.mahadasyam@sony.com; h=from:subject:message-id;
 bh=Bc6B30GXoro1QIrZ2ACQX8CrnIUIWdRhjjFxqv9HIMo=;
 b=owGbwMvMwCU2bX1+URVTXyjjabUkhsx3Z37uWVxx1i2qbb66zaSW3DoDlY4+ifSDy46883T8v
 7viDa9QRykLgxgXg6yYIkupUvWvvSuClvScea0IM4eVCWQIAxenAEykfCMjw8Wldx+UeUe/bY9Q
 r7h2LLI0ZpnpBMFr131n2x7d8fZcnCQjw52Q28H35i9kDlb/uSs8Riu36MWKGc6xAm90557hZTg
 VxwcA
X-Developer-Key: i=shashank.mahadasyam@sony.com; a=openpgp;
 fpr=75227BFABDA852A48CCCEB2196AF6F727A028E55

struct device_driver's mod_name is not set by a number of bus' driver registration
functions. Without that, built-in drivers don't have the module symlink in sysfs.
We want this to go from unbound driver name -> module name -> kernel config name.
This is useful on embedded platforms to minimize kernel config, reduce kernel size,
and reduce boot time.

In order to achieve this, mod_name has to be set to KBUILD_MODNAME, and this has
to be done for all buses which don't yet do this.

Here are some treewide stats:
- 110 registration functions across all bus types
- 20 of them set mod_name
- Remaining 90 do not set mod_name:
    1. 36 functions under pattern 1:
        They have a __register function + register macro. KBUILD_MODNAME needs to
        be passed and the function needs to take mod_name as input.
    2. 42 functions under pattern 2:
        These have no macro wrapper. They need a double-underscore rename + macro
        wrapper to make them similar to pattern 1.
    3. Remaining 12 do not have such a clean registration interface. More analysis
       is required.

We plan to start with pattern 1, since it's the easiest category of changes.
Within that, for now we're only sending the platform patch. If we get the go-ahead
on that, we'll send the remaining ones.

Patch 3 depends on patches 1 and 2.

Co-developed-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Rahul Bukte <rahul.bukte@sony.com>
Signed-off-by: Shashank Balaji <shashank.mahadasyam@sony.com>
---
Changes in v4:
- Initialize module_kset in do_basic_setup() before do_initcalls() (Gary)
- Add commit body to the documentation patch (Greg)
- Link to v3: https://patch.msgid.link/20260422-acpi_mod_name-v3-0-a184eff9ff6f@sony.com

Changes in v3:
- Initialize module_kset on-demand (Greg)
- Make coresight driver registration happen through a macro (Greg)
- Split up the patch adding mod_name to platform driver registrations (Greg)
- Link to v2: https://patch.msgid.link/20260421-acpi_mod_name-v2-0-e73f9310dad3@sony.com

Changes in v2:
- Drop acpi patch, send platform instead (Rafael)
- Link to v1: https://patch.msgid.link/20260416-acpi_mod_name-v1-0-1a4d96fd86c9@sony.com

To: Suzuki K Poulose <suzuki.poulose@arm.com>
To: Mike Leach <mike.leach@linaro.org>
To: James Clark <james.clark@linaro.org>
To: Alexander Shishkin <alexander.shishkin@linux.intel.com>
To: Maxime Coquelin <mcoquelin.stm32@gmail.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <ojeda@kernel.org>
To: Boqun Feng <boqun@kernel.org>
To: Gary Guo <gary@garyguo.net>
To: Björn Roy Baron <bjorn3_gh@protonmail.com>
To: Benno Lossin <lossin@kernel.org>
To: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
To: Trevor Gross <tmgross@umich.edu>
To: Richard Cochran <richardcochran@gmail.com>
To: Jonathan Corbet <corbet@lwn.net>
To: Shuah Khan <skhan@linuxfoundation.org>
To: Luis Chamberlain <mcgrof@kernel.org>
To: Petr Pavlu <petr.pavlu@suse.com>
To: Daniel Gomez <da.gomez@kernel.org>
To: Sami Tolvanen <samitolvanen@google.com>
To: Aaron Tomlin <atomlin@atomlin.com>
To: Mike Leach <mike.leach@arm.com>
To: Leo Yan <leo.yan@arm.com>
Cc: linux-kernel@vger.kernel.org
Cc: coresight@lists.linaro.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: driver-core@lists.linux.dev
Cc: rust-for-linux@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: Shashank Balaji <shashank.mahadasyam@sony.com>
Cc: Rahul Bukte <rahul.bukte@sony.com>
Cc: Daniel Palmer <daniel.palmer@sony.com>
Cc: Tim Bird <tim.bird@sony.com>
Cc: linux-modules@vger.kernel.org

---
Shashank Balaji (4):
      kernel: param: initialize module_kset before do_initcalls()
      coresight: pass THIS_MODULE implicitly through a macro
      driver core: platform: set mod_name in driver registration
      docs: driver-api: add mod_name argument to __platform_register_drivers()

 Documentation/driver-api/driver-model/platform.rst |  3 ++-
 drivers/base/platform.c                            | 21 ++++++++++++++-------
 drivers/hwtracing/coresight/coresight-catu.c       |  2 +-
 drivers/hwtracing/coresight/coresight-core.c       |  9 +++++----
 drivers/hwtracing/coresight/coresight-cpu-debug.c  |  3 +--
 drivers/hwtracing/coresight/coresight-funnel.c     |  3 +--
 drivers/hwtracing/coresight/coresight-replicator.c |  3 +--
 drivers/hwtracing/coresight/coresight-stm.c        |  2 +-
 drivers/hwtracing/coresight/coresight-tmc-core.c   |  2 +-
 drivers/hwtracing/coresight/coresight-tnoc.c       |  2 +-
 drivers/hwtracing/coresight/coresight-tpdm.c       |  3 +--
 drivers/hwtracing/coresight/coresight-tpiu.c       |  2 +-
 include/linux/coresight.h                          |  7 +++++--
 include/linux/module.h                             |  4 ++++
 include/linux/platform_device.h                    | 17 +++++++++--------
 init/main.c                                        |  1 +
 kernel/params.c                                    | 21 +++++++++------------
 rust/kernel/platform.rs                            |  4 +++-
 18 files changed, 61 insertions(+), 48 deletions(-)
---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260416-acpi_mod_name-f645a76e337b

Best regards,
--  
Shashank Balaji <shashank.mahadasyam@sony.com>

