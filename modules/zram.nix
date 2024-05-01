{
  zramSwap = {
    enable = true;
    priority = 1000;
    algorithm = "zstd";
    swapDevices = 1;
    memoryPercent = 100;
  };
  boot.kernel.sysctl = {
    # Swapping with zram is much much faster than paging so we prioritize it.
    "vm.swappiness" = 100;
    # With zstd, the decompression is so slow
    # that that there's essentially zero throughput gain from readahead.
    # Prevents uncompressing any more than you absolutely have to,
    # with a minimal reduction to sequential throughput
    "vm.page-cluster" = 0;
  };
}
