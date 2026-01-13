export type InstancedRenderItem = {
    index: number;
    depth: number;
    depthSort: number;
};
/**
 * A class that creates and manages a list of render items, used to determine the rendering order based on depth.
 */
export declare class InstancedRenderList {
    /**
     * The main array that holds the list of render items for instanced rendering.
     */
    array: InstancedRenderItem[];
    protected pool: InstancedRenderItem[];
    /**
     * Adds a new render item to the list.
     * @param depth The depth value used for sorting or determining the rendering order.
     * @param index The unique instance id of the render item.
     */
    push(depth: number, index: number): void;
    /**
     * Resets the render list by clearing the array.
     */
    reset(): void;
}
//# sourceMappingURL=InstancedRenderList.d.ts.map