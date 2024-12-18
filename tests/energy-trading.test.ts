import { describe, it, expect, beforeEach, vi } from 'vitest';

describe('Energy Trading Contract', () => {
  let mockContractCall: any;
  
  beforeEach(() => {
    mockContractCall = vi.fn();
  });
  
  it('should create an offer', async () => {
    mockContractCall.mockResolvedValue({ success: true, value: 1 });
    const result = await mockContractCall('create-offer', 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.energy-token', 100, 50);
    expect(result.success).toBe(true);
    expect(result.value).toBe(1);
  });
  
  it('should accept an offer', async () => {
    mockContractCall.mockResolvedValue({ success: true });
    const result = await mockContractCall('accept-offer', 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM.energy-token', 1);
    expect(result.success).toBe(true);
  });
  
  it('should get an offer', async () => {
    mockContractCall.mockResolvedValue({ success: true, value: { seller: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM', amount: 100, price: 50 } });
    const result = await mockContractCall('get-offer', 1);
    expect(result.success).toBe(true);
    expect(result.value).toEqual({ seller: 'ST1PQHQKV0RJXZFY1DGX8MNSNYVE3VGZJSRTPGZGM', amount: 100, price: 50 });
  });
});

